---
name: starkwm-release-delivery
license: BSD-3-Clause
description: "Deliver swm, sbar, sborders, stags, or skbd releases when asked to bump, commit, tag, push, or publish them. Push the version tag and follow the tag-triggered release workflow. Attach Homebrew bottles by hand as a recovery or synchronize StarkWM website documentation only when asked. Use github-release-notes alone for notes-only drafts; exclude ordinary feature work."
---

# StarkWM release delivery

Do the release actions the user asked for, then verify local, remote, and GitHub state. The references are hints: read the current files, workflows, and release metadata before relying on them.

## Scope

- Releasing a new version covers the version bump, validation, commit, tag, push, watching the release workflow, applying notes, and verifying the release, bottle, and tap PR. A request to only bump, tag, or push stops there. Drafting notes alone does not authorize publication. Within the requested scope, ask only about a decision that is genuinely missing.
- Publishing an existing tag skips the bump and branch push, and validates that revision. An untagged version already committed can be published without incrementing it. A bottle recovery or website update alone is only that work.
- Keep the requested version, branch, channel, and any restriction on running the app. For "the next version", derive the next patch from the source and remote tags; ask only if the version or channel is still ambiguous. Follow the project's current channel and never silently turn a prerelease series stable.
- Read [projects](references/projects.md) and [release workflow](references/automated-release.md). Read [bottles](references/bottles.md) and [website](references/website.md) only when asked.

## Inspect

1. Find the checkout. Read `AGENTS.md`, the Makefile, `Version.swift`, `Package.swift`, docs, and workflows.
2. Use `jj` when `.jj` exists, otherwise Git. Check status, history, bookmarks, tags, and remotes, and confirm the remote is the intended GitHub repository. Keep unrelated edits out of the release commit and push range.
3. Fetch, then record the previous release tag, the target tag's state, the channel, and the branch. An existing tag or release is state to inspect, not permission to replace it.
4. Resume a partial release only when files, commit, tag, and published metadata agree with the request. Never create duplicate bumps or releases.

## Bump and validate

1. Edit only the version string in `Version.swift`, in the tag's spelling.
2. Run the project's build, lint, and full tests, then the built binary's `--version` and `git diff --check`. The version, tag, and release title must match. An earlier run or `--skip-build` does not count after a version edit or rebase.
3. For sandbox access failures (Swift caches, sockets, macOS APIs, `.git/objects`), rerun with the needed access or temporary writable caches. SwiftPM's `--disable-sandbox` does not lift the agent's sandbox. Do not change code, dependency pins, or Git internals to get around the environment. Real failures stand until fixed or waived by the user.
4. Respect any instruction to leave desktop testing to the user. Build and test results do not prove running-app behavior.

## Commit, tag, and push

Commands are in [publication](references/publication.md).

1. Make a focused commit, usually `Bump version to <tag>`, and record its full commit ID.
2. Fetch again before pushing. If the remote moved, rebase only the unpublished release commit, recheck the diff, and rerun validation.
3. Point the branch and tag at the final commit. Move a tag only if it was never pushed; never move a remote release tag.
4. Push the explicit branch and tag. Never push all refs or force.
5. Verify the remote branch and peeled tag resolve to the recorded commit. If the branch advanced again, report the race instead of rewinding it.

## Publish

The release workflow creates the release, so do not run `gh release create` or upload assets. Follow [release workflow](references/automated-release.md). Draft notes with [github-release-notes](../github-release-notes/SKILL.md) from the final tag and the previous release, keeping the file outside the checkout.

After any uncertain push, edit, or upload, inspect remote state before retrying. Never delete or replace a published release, tag, or asset. If the state cannot be reconciled within the request, stop and report it.

## Report

Give the version, full commit, validation run, remote refs, release URL, workflow run URL and conclusion, bottle asset, and tap PR URL and state (or why the tap job was skipped). Add any requested bottle or website result, remaining failures, manual checks still needed, and the final checkout status with any retained unrelated edits. Never claim publication from local validation alone.
