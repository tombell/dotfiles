# Publication commands

Examples use fish, `origin`, and `main`; substitute the inspected values.

## Jujutsu

```fish
jj commit -m "Bump version to $release_tag"
set release_revision (jj log --no-graph -r @- -T 'commit_id')
set release_change (jj log --no-graph -r $release_revision -T 'change_id')
jj git fetch --remote origin
```

Only if `main@origin` advanced, rebase and then rerun validation:

```fish
jj rebase -r $release_change -o main@origin
set release_revision (jj log --no-graph -r $release_change -T 'commit_id')
```

```fish
jj bookmark set main -r $release_revision
jj tag set $release_tag -r $release_revision
jj git push --remote origin --bookmark main --tag $release_tag
```

A bookmark push also sends its unpushed ancestors, so inspect the range first. Use `jj tag set --allow-move` only on a tag that was never pushed. Without `.jj`, use a fast-forward branch push and an explicit tag push.

## Verify refs

```fish
git ls-remote origin refs/heads/main "refs/tags/$release_tag" "refs/tags/$release_tag^{}"
```

The branch and tag must equal `release_revision`; for an annotated tag, use the `^{}` line. `targetCommitish` does not prove the tag's commit. When publishing an older tag, `main` can be ahead; do not move it back.

## Verifier

[scripts/verify_release.py](../scripts/verify_release.py) is read-only: it calls only `git ls-remote` and `gh release view`. Run it by absolute path after the workflow publishes and the notes are applied:

```fish
python3 /absolute/path/to/starkwm-release-delivery/scripts/verify_release.py \
  --checkout $release_checkout --remote origin --branch main \
  --repo $release_repo --tag $release_tag --commit $release_revision \
  --notes-file $release_notes --prerelease \
  --asset $bottle_filename
```

Use `--stable` for a stable release, omit `--branch` for an older tag whose branch has moved on, and repeat `--asset` as needed. It checks the tag commit, branch, title, draft and channel state, the notes body (ignoring CRLF and one trailing newline), and that each asset is uploaded with a `sha256:` digest. A failure means inspecting the reported state; rerunning it fixes nothing.
