# Publication and verification

The examples use fish and the common `main`/`origin` convention. Set the variables from the inspected checkout. Use the requested target branch when it differs.

## Jujutsu sequence

After the scoped version edit and passing validation, the usual clean-checkout sequence is:

```fish
jj commit -m "Bump version to $release_tag"
set release_revision (jj log --no-graph -r @- -T 'commit_id')
set release_change (jj log --no-graph -r $release_revision -T 'change_id')
jj git fetch --remote origin
```

Inspect the fetched graph before moving refs. If remote `main` advanced and the commit is unpublished, current Jujutsu supports this scoped rebase:

```fish
jj rebase -r $release_change -o main@origin
set release_revision (jj log --no-graph -r $release_change -T 'commit_id')
```

Rerun validation after the rebase. `release_revision` must refer to the final commit after all rewrites.

```fish
jj bookmark set main -r $release_revision
jj tag set $release_tag -r $release_revision
jj log --no-graph -r main -T 'commit_id ++ "\n"'
jj log --no-graph -r $release_tag -T 'commit_id ++ "\n"'
jj git push --remote origin --bookmark main --tag $release_tag
```

These commands assume the chosen tag is new. To move a tag created locally during this run after a rebase, current Jujutsu uses `jj tag set --allow-move`, but only after verifying that tag has never been published. Do not use it on a remote release tag. Inspect the outgoing range because a bookmark push also sends its unpushed ancestors. Use Git branch/tag commands only in checkouts without `.jj`.

## Verify refs directly

Git transport inspection is suitable in a Jujutsu checkout and does not mutate local history:

```fish
git ls-remote origin refs/heads/main "refs/tags/$release_tag" "refs/tags/$release_tag^{}"
```

The branch hash and tag's commit must equal `release_revision`. For an annotated tag, use the `^{}` hash, not the tag object's hash. Check for missing refs explicitly. When publishing an existing older tag, confirm its intended commit; current `main` can be ahead and must not be moved back.

## Publish from the notes file

Load `github-release-notes` and prepare the final body before this step. Keep the file outside the application repository. For the currently used prerelease convention:

```fish
gh release create $release_tag --repo $release_repo --title $release_tag --notes-file $release_notes --verify-tag --prerelease --latest=false
```

For an explicitly selected stable release, omit `--prerelease` and choose latest-release behavior from the request and checked repository convention. Do not pass generated notes as a shell string. A publish command that returns an uncertain result must be followed by a state query before any retry. An existing matching publication is already complete; edit an existing body only when updating it is within the request.

## Verify publication directly

Inspect the published release with:

```fish
gh release view $release_tag --repo $release_repo --json tagName,name,isDraft,isPrerelease,publishedAt,body,url
```

Require the intended tag and title, `isDraft: false`, the selected release channel, and a publication timestamp and URL. Compare the body with the prepared notes, allowing CRLF normalization and one final newline. Verify the remote tag commit with `git ls-remote` as described above. For a new release, also require the remote branch to match the recorded commit. For an existing older tag, the branch may have advanced.

After an uncertain publication response, inspect the release and remote refs before retrying. Do not trust `targetCommitish`, which may be a branch name, to establish tag equality. Resolve or report any mismatch before claiming publication is complete.
