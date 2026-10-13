---
name: starkwm-release-delivery
description: "Deliver swm, sbar, sborders, stags, or skbd releases when asked to bump, commit, tag, push, or publish them. Attach their Homebrew bottles or synchronize their StarkWM website documentation only when asked. Use github-release-notes alone for notes-only drafts; exclude ordinary feature work."
---

# StarkWM release delivery

Complete the release actions the user requested and verify the resulting local, remote, and GitHub state. Treat repository details below as navigation hints. Read current files and live release metadata before using commands or conventions.

## Establish the scope

- A request to release or publish a new version covers the version bump, validation, focused commit, tag, push, notes, and GitHub Release. A request limited to bumping, tagging, or pushing stops at that boundary. Notes alone do not authorize publication.
- For publication of an existing tag, skip the bump and branch push. For a bottle attachment or website update alone, do only that work.
- Preserve the requested version, branch or bookmark, stable/prerelease choice, and any restriction on running the app. If the user asks for the next version without naming one, derive the next patch from the checked version and remote tags when the sequence is clear. Ask only when the intended version or release channel remains ambiguous.
- Follow the project's current release channel when no channel is specified. For a first publication without project history, use the shared StarkWM prerelease convention unless the user selected another channel. Do not silently turn a prerelease series into a stable release.
- Read the reference for the chosen project: [swm](references/swm.md), [sbar](references/sbar.md), [sborders](references/sborders.md), [stags](references/stags.md), or [skbd](references/skbd.md). Read [bottles](references/bottles.md) and [website documentation](references/website.md) only when requested. A release does not automatically include either follow-up or Homebrew formula edits.

## Inspect before changing files

1. Locate the requested checkout, normally `/Users/tombell/Code/starkwm/<project>`. Read applicable `AGENTS.md` files, the Makefile, any version source and template, Package.swift, relevant docs, and CI workflow.
2. Use `jj` whenever `.jj` exists. Inspect status, recent history, bookmarks, tags, and remotes. Otherwise use Git. Confirm that the chosen remote and GitHub owner/repository describe the same project. Keep unrelated edits and unpublished work out of the release commit and push range.
3. Check live remote refs and recent GitHub Releases. Fetch before preparing a new release so the base is current. Record the previous release tag, requested tag state, release channel, and target branch. An existing tag or release is a state to inspect, not permission to replace it.
4. Continue from a completed stage only when its files, commit, tag, and published metadata agree with the request. Do not create duplicate bumps or releases. If the intended changes are mixed with unrelated work, isolate them in a suitable checkout without discarding the user's edits.

## Prepare the version and validate it

1. Inspect the project's version mechanism first. Run the current `bump_version` target with the exact selected version spelling. It should regenerate only the project's version source. Review the diff against the template; investigate any additional changed files. If version support is missing in an older or different checkout, keep any required setup within the requested release scope rather than assuming the target exists.
2. Run the project's build, lint, and full test suite using the selected repository reference. Use the current toolchain and CI instructions. Do not use an old successful run or `--skip-build` as validation after a version edit or rebase.
3. Check the freshly built binary with `--version` when supported and check the diff for whitespace errors. The embedded version, tag, and release title must agree in the project's chosen spelling. A help check does not verify an embedded version; record an unavailable version check explicitly for a tag-only release without version support. Respect any instruction to leave desktop testing to the user; a build and test run do not prove running-app behavior.
4. For access failures involving Swift caches, local sockets, macOS APIs, or `.git/objects`, rerun the affected command with the required permitted access or writable temporary caches. SwiftPM's `--disable-sandbox` does not remove the agent's sandbox. Do not change application code, dependency pins, or Git internals to bypass an environment failure. Keep genuine build or test failures unresolved until fixed or explicitly waived by the user.

## Commit, tag, and push

1. Create a focused version commit. Follow recent message style, usually `Bump version to <tag>`. Avoid conventional commit prefixes unless the repository already uses them. Record the full release commit ID rather than relying on `@-` after later operations.
2. Fetch again immediately before pushing. The release commit must descend from the current remote target branch. If the remote advanced, rebase only the unpublished release commit onto it, resolve any version conflict deliberately, inspect the new diff, and rerun validation for the resulting revision. Do not rewrite published history or unrelated commits.
3. Set the intended local bookmark/branch and tag to the final release commit. A tag created locally during this run may be moved after a rebase only while it has never been published. Check the remote tag first. Never move an existing remote release tag automatically.
4. Inspect the push range and use an explicit bookmark/branch and tag. With current Jujutsu, the common shape is `jj git push --remote origin --bookmark main --tag <tag>`. With Git, use an ordinary fast-forward branch push and explicit tag push. Do not push all refs or force an update.
5. Verify the local branch/bookmark and tag, then query the remote directly. For a new release, remote branch and tag must resolve to the recorded commit. Peel annotated tags to their commit. Use the commands in [publication verification](references/publication.md). If the branch advanced again, inspect the new commit and report the race; do not rewind it to manufacture equality.

## Publish and verify the GitHub Release

1. Load and use the existing [github-release-notes skill](../github-release-notes/SKILL.md). Draft from the final tagged revision and the previous release, checking actual source and docs. Recompute the range after a rebase. Keep the final Markdown in a notes file outside the application checkout.
2. Complete the requested local work and checks before any final approval required by the environment. The release request supplies scope authorization; ask again only for a real missing decision or permission requirement.
3. Publish against the verified remote tag with an explicit repository, title, notes file, and channel. Use `--verify-tag`. For the current prerelease convention, also use `--prerelease --latest=false`. Read [publication verification](references/publication.md) for commands and retry behavior.
4. Verify the published title, tag, draft state, prerelease state, publication timestamp, and body against the prepared notes. `targetCommitish` alone is not proof of the tag's commit. After an uncertain push, create, edit, or upload outcome, inspect remote state before retrying. If mismatched state cannot be resolved within the user's request, stop that mutation and report the discrepancy. Do not delete or replace a published release, tag, or asset to make a retry work.

## Finish

Report the version, full release commit, completed validation, remote-ref result, and GitHub Release URL when published. Include any requested bottle or website verification, remaining failure, or manual desktop check. Inspect final checkout status and identify retained unrelated edits. Never report publication, asset delivery, or deployment complete from local validation alone.
