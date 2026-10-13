# Requested release documentation synchronization

Use only when the user requests website documentation or publication. A source release does not authorize a website change. Follow the requested delivery boundary, whether it is a local edit, commit, push, or deployed-page verification.

Usual checkout: `/Users/tombell/Code/starkwm/website`. Verify the current instructions, checkout state, page structure, pinned tools, remote, and deployment workflow. Locate the requested project's actual pages before editing.

| Project | Current documentation entrypoint |
| --- | --- |
| swm | `content/swm/_index.md` |
| sbar | `content/sbar/_index.md`, with configuration/provider pages |
| skbd | `content/skbd/_index.md` |
| stags | `content/stags/_index.md`, with CLI, setup, tag/view, and recovery pages |
| sborders | No website section was present at inspection; check again and create one only within requested new-documentation work |

1. Compare the website page with source and docs at the exact released tag. Update version references, installation/source-checkout commands, behavior descriptions, and release-compatibility notes that the tagged evidence supports. Keep unreleased behavior clearly tied to its source revision. Preserve existing front matter, heading anchors, and the plain, text-led style.
2. For sbar, inspect schema downloads, development-schema links, and example links as well as the entrypoint. A new release can make previously marked unreleased settings available. Check whether requested synchronization needs the published schema to change rather than only replacing a version string.
   For a first stags release, replace source-only installation and the no-published-release statement only after the publication is verified. Check the linked guides as well as the entrypoint. For skbd, preserve the distinction between the `skbd@2` formula/service name and the application version.
3. Build with the current pinned Hugo through `mise exec -- hugo`. Use temporary cache and output directories outside the checkout. Inspect `.mise.toml` and the workflow's Hugo version; validate with the deployment version too if they differ and compatibility is uncertain.

```fish
mise exec -- hugo --gc --minify --cacheDir $website_cache --destination $website_preview
```

4. Check generated content and links, then inspect a real local browser preview of the affected pages. Include narrow layouts and both themes where the change affects rendering. A local Hugo success is separate from browser verification.
5. If delivery was requested, make a focused website commit such as `Update <project> docs for <tag>` and push only its intended bookmark/branch with `jj` when `.jj` exists. Keep it separate from the application release commit and any formula changes.
6. For requested publication, verify the remote commit, the Pages workflow for that commit, and the live page's changed content and links. Fetch the live page without relying on a cached response. If the deployment fails or live content is stale, report that result instead of calling the website published. Finish with checkout status and any retained unrelated edits.
