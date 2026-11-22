---
name: github-release-notes
license: BSD-3-Clause
description: Draft or update GitHub Release notes from a repository's changes, including the notes for a requested release publication. Use for release bodies, not ordinary changelog files or pull request descriptions.
---

# GitHub release notes

Write concise notes on what a release changes for its users, using the repository's own facts and terms.

## Gather the facts

- Read the repository instructions, the target tag, the previous release tag, and the changes between them. Check pull requests, tests, docs, and recent releases where they clarify user impact. Use `jj` when `.jj` exists.
- Describe only work in the tagged revision, and never infer a change from a commit title alone. Note whether each change is public, internal, or docs only.
- Confirm the version spelling, title, prerelease status, minimum platform or toolchain versions, and docs path at the target revision.

## Write the body

Use this order and omit empty sections:

```markdown
One short sentence about the main change or purpose of this release.

## Breaking changes

- What users must change to upgrade.

## Added

- A new capability and how to use it.

## Changed

- A changed behavior or meaningful maintenance change.

## Fixed

- The failure and the corrected behavior.

Requires [verified minimum versions or platforms].

[Documentation](link to in-repo docs at this tag) · [Full changelog](link comparing previous and current tags)
```

- Title the release with the version tag. Open with a factual sentence, not a repeat of the title; for an initial release, say what the project does.
- Keep bullets specific, usually one or two sentences. Lead with the result, and add a command, option, or compatibility detail when it helps. Group related changes; do not paste a commit log or add `Changes` or `Miscellaneous` sections.
- Include tests, CI, or docs changes only when material. For a maintenance-only release, say public behavior is unchanged if verified.
- Include the requirements line only when minimums are documented for this tag, the Documentation link only when the repository has in-repo docs, and the changelog link only when a previous tag exists. Drop the separator if one link remains.
- Keep the tone plain. No promotional claims or promises the diff and tests do not support.

## Finish

For notes alone, give a ready-to-paste Markdown body; that does not authorize publishing or changing refs. When a release was also requested, use the body for it and verify the published title, tag, prerelease status, and body.
