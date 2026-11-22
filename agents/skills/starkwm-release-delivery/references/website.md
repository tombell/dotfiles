# Website documentation

Only when asked; a source release does not authorize website changes. Stop at the requested boundary: edit, commit, push, or verified deploy. Work in the `starkwm/website` checkout and read its instructions, `.mise.toml`, and deploy workflow.

| Project | Entry point |
| --- | --- |
| swm | `content/swm/_index.md` |
| sbar | `content/sbar/_index.md`, plus configuration and provider pages |
| sborders | `content/sborders/_index.md`, plus CLI, setup, configuration, and compatibility pages |
| skbd | `content/skbd/_index.md` |
| stags | `content/stags/_index.md`, plus CLI, setup, tag/view, and recovery pages |

1. Compare the pages with the source and docs at the released tag. Update only what the tag supports: versions, install commands, behavior, and compatibility. Keep front matter, heading anchors, and the plain style. For sbar, also check schema downloads and example links, since a release can make settings marked unreleased available. For skbd, keep the `skbd@2` formula name distinct from the app version.
2. Build with cache and output directories outside the checkout. If the deploy workflow's Hugo version differs from `.mise.toml`, check with that one too.

```fish
mise exec -- hugo --gc --minify --cacheDir $website_cache --destination $website_preview
```

3. Check links and preview the changed pages in a browser, including narrow widths and both themes when rendering changes.
4. To deliver, make a focused commit such as `Update <project> docs for <tag>`, separate from app and formula commits, and push only that branch.
5. To publish, verify the remote commit, the Pages run for it, and the live page fetched without cache. Report a failed or stale deploy as such.
