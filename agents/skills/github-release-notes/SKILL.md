---
name: github-release-notes
description: Draft or update GitHub Release notes from a repository's changes, including the notes for a requested release publication. Use for release bodies, not ordinary changelog files or pull request descriptions.
---

# GitHub release notes

Write concise notes that explain what a release changes for its users. Apply the same shape across projects while using each repository's actual facts and terminology.

## Gather the facts

- Read repository instructions, the target tag or commit, the previous release tag, and the changes between them. Check relevant pull requests, tests, documentation, and recent GitHub Releases when they clarify user impact or existing requirements. Use `jj` for source control when `.jj` exists.
- Include work that is in the tagged revision. Do not infer features or fixes from a commit title alone. Check whether a change is public, internal, or documentation only, and describe its effect accurately.
- Confirm the project's version spelling, release title, prerelease status, minimum platform or toolchain versions, and documentation path before using them. Recent releases are evidence, not a substitute for checking the target revision.

## Write the body

Use this order. Omit a section when it has no real content:

```markdown
One short sentence about the main change or purpose of this release.

## Breaking changes

- State what users need to change to upgrade.

## Added

- Describe a new capability and how it can be used.

## Changed

- Describe a changed behavior or a meaningful maintenance change.

## Fixed

- Describe the failure and the corrected behavior.

Requires [verified minimum versions or platforms].

[Documentation](link to existing in-repo docs at this tag) · [Full changelog](link comparing previous and current tags)
```

- Use the version tag as the release title, following the repository's tag spelling. Start the body with a factual sentence, not a repeat of the title. For an initial release, say what the project does.
- Keep bullets specific and usually one or two sentences. Lead with the result, then include a command, option, limit, or compatibility detail when it helps someone use or upgrade the release. Group related changes. Do not paste a commit log.
- Use `Added`, `Changed`, and `Fixed` in that order. Put `Breaking changes` first only when users must take action. Do not add empty headings, a generic `Changes` section, or a `Miscellaneous` section.
- Include internal changes such as tests, CI, formatting, or docs when they are material to the release. For a maintenance-only release, say plainly that public behavior is unchanged if verified.
- Include the requirements sentence only when minimums are documented and verified for this tag. Include the Documentation link only if the tagged repository contains an internal documentation page to link to; omit it when the repository has no internal docs. Add a full changelog link when a previous tag exists. Build links for the actual repository and tags, and omit the separator when only one link remains.
- Keep the tone plain and concrete. Avoid promotional claims, unexplained implementation detail, and promises about behavior that the diff or tests do not establish.

## Finish the request

When asked for notes alone, provide a ready-to-paste Markdown body. When the user has also requested a GitHub Release, use that body for the release and verify the published title, tag, prerelease status, and body. A request to draft notes by itself does not authorize publishing or changing refs.
