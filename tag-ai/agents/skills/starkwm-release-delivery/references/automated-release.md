# Release workflow

Each project's `.github/workflows/release.yml` runs on `v*` tag pushes and calls `starkwm/workflows/.github/workflows/release-bottle.yml` at a pinned commit, which can differ between projects. Read the shared workflow and its `scripts/` at that pin before relying on this summary.

1. **bottle**: requires a `vX.Y.Z` tag, runs `make lint` and `make test`, checks that `--version` prints `<version-prefix> <tag>`, then builds and pours the bottle. The tested bytes are kept as the run artifact and cached for reruns.
2. **publish**: checks the tag still points at the tested commit. If no release exists, creates a draft prerelease titled with the tag (`--latest=false`), using the annotated tag message or else GitHub-generated notes. Uploads the bottle only to a draft, checks its digest, then publishes.
3. **tap**: opens a formula PR in `starkwm/homebrew-formulae` when the tap app is configured. Otherwise it is skipped with a warning and the formula stays in the artifact.

## Steps

1. Before pushing the tag, check for an existing release. If one exists, inspect it and report instead of pushing: a published release without the bottle makes the publish job fail.
2. Find and watch the run whose `headBranch` is the tag and `headSha` is `release_revision`. If none appears within a few minutes, check that the tag was pushed and matches the pattern.

```fish
gh run list --repo $release_repo --workflow release.yml --event push --json databaseId,headBranch,headSha,status,conclusion,url --limit 5
gh run watch $run_id --repo $release_repo --exit-status
```

3. `jj tag set` creates a lightweight tag, so the body is GitHub-generated. After the run succeeds, apply the prepared notes unless the user wanted the generated body. This does not change draft, channel, or asset state.

```fish
gh release edit $release_tag --repo $release_repo --notes-file $release_notes
```

4. The workflow publishes prereleases only. For a requested stable release, run `gh release edit $release_tag --repo $release_repo --prerelease=false` with `--latest` chosen from the request.
5. Run the verifier in [publication](publication.md) with `--asset <formula>-<version without v>.arm64_golden_gate.bottle.tar.gz`. Find the tap PR with `gh pr list --repo starkwm/homebrew-formulae --search $release_tag --state all` and report it. Merging it is a separate request.

## Failures

- Read `gh run view $run_id --repo $release_repo --log-failed` before changing anything.
- A lint, test, or version failure needs a fix in a new commit and a new tag. Never move a published tag.
- For a transient runner, network, or GitHub failure, rerun the failed jobs: `gh run rerun $run_id --repo $release_repo --failed`.
- If publishing stopped on a published release without the bottle, report it. Attaching it by hand needs approval; see [bottles](bottles.md).
- Never delete a release or tag, use `--clobber`, or create the release by hand.
