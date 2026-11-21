# Tag-triggered release automation

Some projects publish their GitHub Release, Homebrew bottle, and tap formula PR from a workflow that runs when a version tag is pushed. A project uses this path when `.github/workflows/release.yml` triggers on `v*` tag pushes. At the time of writing, `swm` and `skbd` do; `sbar`, `sborders`, and `stags` do not. Check the checkout rather than relying on that list.

## What the workflow does

`swm` defines the jobs inline and calls its own `scripts/`. `skbd` calls the shared `starkwm/workflows/.github/workflows/release-bottle.yml` at a pinned commit. Read the workflow and scripts at the pinned revision before relying on the details below.

1. **bottle** (macOS runner): requires a `vX.Y.Z` tag, runs `make lint` and `make test`, checks that `--version` prints the expected prefix and tag, then builds and pours the Golden Gate bottle. The tested bottle, formula, commit, and notes inputs are uploaded as the run artifact and cached by run ID so reruns reuse the same bytes.
2. **publish**: checks that the tag still points at the tested commit, then creates the release if it does not exist. It is created as a draft prerelease titled with the tag and `--latest=false`. The body comes from the annotated tag message when there is one, otherwise from GitHub-generated notes starting at the previous tag. The job uploads the bottle only while the release is a draft, checks the asset digest, and then publishes it.
3. **tap**: when the tap app is configured, opens a formula update PR in `starkwm/homebrew-formulae`. When it is not, the job is skipped, the publish job emits a warning, and the tested formula stays in the run artifact.

## Delivery steps

1. Do the version bump, validation, commit, tag, push, and ref verification in `SKILL.md` as usual. The tag must match `v[0-9]+.[0-9]+.[0-9]+` or the workflow does not run.
2. Do not run `gh release create` or `gh release upload` for this tag. A release that already exists when the workflow starts must be a draft that does not yet have the bottle. A published release without the bottle makes the publish job fail. If a release for the tag already exists, inspect it before pushing and report the conflict instead of pushing.
3. Find the run for the pushed tag and wait for it:

```fish
gh run list --repo $release_repo --workflow release.yml --event push --json databaseId,headBranch,headSha,status,conclusion,url --limit 5
gh run watch $run_id --repo $release_repo --exit-status
```

Pick the run whose `headBranch` is the tag and whose `headSha` is `release_revision`. If no run appears within a few minutes, check that the tag was pushed and matches the trigger pattern. Do not treat a run for a different SHA as evidence.

4. Prepare notes with `github-release-notes` while the run is in progress. Jujutsu's `jj tag set` creates a lightweight tag, so the workflow publishes GitHub-generated notes. Replace them after the run succeeds:

```fish
gh release edit $release_tag --repo $release_repo --notes-file $release_notes
```

Editing only the body does not change the draft, prerelease, or asset state. Leave the generated body only when the user asked for that.

5. The workflow publishes prereleases only. For an explicitly requested stable release, change the channel after the run succeeds with `gh release edit $release_tag --repo $release_repo --prerelease=false`, choosing `--latest` from the request and repository convention.
6. Verify with the read-only verifier in [publication verification](publication.md), passing `--asset` with the bottle filename (`<formula>-<version without v>.arm64_golden_gate.bottle.tar.gz`, for example `swm-0.0.33.arm64_golden_gate.bottle.tar.gz`). Then find the tap PR with `gh pr list --repo starkwm/homebrew-formulae --search $release_tag --state all` and report its URL and state. Merging the tap PR is a separate request.

## Failures and retries

- Read the failed job log with `gh run view $run_id --repo $release_repo --log-failed` before changing anything.
- A lint, test, or version-check failure is a release failure. Fix it in a new commit and a new tag. Do not move a published tag to make the run pass.
- For a transient runner, network, or GitHub failure, rerun only the failed jobs with `gh run rerun $run_id --repo $release_repo --failed`. A full rerun replaces the artifact, but the cache keeps the tested bytes for the same run.
- If the publish job stops because a published release lacks the bottle, report it. Attaching the bottle by hand is a recovery step that needs the user's approval, and it must use the bottle from that run's artifact (`gh run download $run_id --repo $release_repo`) following [bottles](bottles.md).
- Never delete a release or tag, use `--clobber`, or create the release by hand to work around the workflow.
