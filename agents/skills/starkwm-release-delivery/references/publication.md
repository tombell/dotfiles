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

## Read-only verifier

Run [scripts/verify_release.py](../scripts/verify_release.py) after publication, using its absolute path and the final commit ID. It calls only `git ls-remote` and `gh release view`; it never commits, fetches, pushes, edits, uploads, or publishes.

```fish
python3 /absolute/path/to/starkwm-release-delivery/scripts/verify_release.py \
  --checkout $release_checkout --remote origin --branch main \
  --repo $release_repo --tag $release_tag --commit $release_revision \
  --notes-file $release_notes --prerelease
```

For an automated release, add `--asset <bottle filename>` to require that asset to be uploaded with a `sha256:` digest. `--asset` can be repeated. Use `--stable` for stable releases. Omit `--branch` when verifying publication of an existing tag whose branch has advanced. The helper compares the resolved remote tag commit, optional branch commit, title, tag, published/non-draft state, release channel, prepared notes, and any requested assets. It allows CRLF normalization and one final newline in the notes body. Other differences fail verification. It uses Python's standard library and installed `git` and `gh`.

Before publication, check refs with `git ls-remote` alone. `gh release view ... --json tagName,name,isDraft,isPrerelease,publishedAt,body,url` can inspect an uncertain outcome. Do not trust `targetCommitish`, which may be a branch name, to establish tag equality. Failures from the helper require inspecting the reported state; rerunning it cannot repair anything.
