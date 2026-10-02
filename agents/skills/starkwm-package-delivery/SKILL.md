---
name: starkwm-package-delivery
description: Update shared Stark Swift package dependencies in consumer projects such as swm, sbar, and sborders. Preserve unrelated edits and protected dependencies, validate the update, and complete scoped delivery when requested.
---

# StarkWM package delivery

Use for dependency updates in StarkWM consumer projects. Package releases and GitHub release notes have their own workflows.

## Inspect the checkout

- Read applicable repository instructions, the Makefile, Package.swift, and Package.resolved. Use the current checkout as the authority for versions and validation commands.
- Use Jujutsu when the checkout has a .jj directory. Record status and save the pre-existing diffs before editing, including any existing manifest or lockfile changes.
- Identify the requested packages and versions, dependencies the user wants preserved, and the requested delivery target. Keep existing exact, minimum-version, or revision requirements unless the update calls for changing them.

## Update and validate

1. Edit the requested requirements in Package.swift, then run `swift package resolve` to regenerate Package.resolved. Do not hand-edit resolved revisions.
2. Inspect both diffs. Confirm the requested versions and revisions agree, protected dependencies remain unchanged, and unrelated lockfile changes are explained. Avoid a blanket dependency update when only named packages should change.
3. Run the checkout's build, lint, and test commands. Keep its test parallelism and other flags. Format only files that need it.
4. Compare the pre-existing diffs with the resulting working copy. Retain all unrelated edits and any intentional user changes within the package files.

Treat cache, socket, or macOS access errors as possible execution restrictions. Diagnose the reported failure before changing source. Writable temporary `CLANG_MODULE_CACHE_PATH` and `SWIFTPM_MODULECACHE_OVERRIDE` paths may resolve cache failures. Use `--disable-sandbox` only when appropriate for the checkout and the specific failure. Report any validation that remains blocked.

## Deliver when requested

Carry forward the user's existing authorization. An update request alone does not authorize a commit, push, or release.

- Inspect the actual change before committing. Use a plain descriptive message consistent with recent commits.
- With unrelated working-copy edits, extract only the update. For an update confined to otherwise untouched package files, a typical command is `jj split -m 'Update Stark package dependencies' Package.swift Package.resolved`. If those files already contain unrelated edits, select the update hunks instead of taking the whole files.
- Inspect the extracted commit and remaining diff before moving a bookmark. Use its verified revision rather than assuming `@-` is always the intended change.
- Before pushing, fetch the relevant remote and inspect the target bookmark and remote history. Incorporate remote changes without discarding local work. Keep the user's requested main or feature-bookmark target.
- Move the target bookmark to the verified update revision. Review `jj git push --remote <remote> --bookmark <bookmark> --dry-run`, then push when authorized. Stop to resolve unexpected conflicts or an unexplained remote-history rewrite.
- Verify the remote bookmark or branch points to the delivered commit. For an updated PR, also verify its head. Compare the remaining working-copy edits with the saved originals.

If a Jujutsu operation fails, inspect whether it partly completed before retrying with the required access. Do not remove lock files or modify Git internals. Check the installed CLI's help for unsupported flags; use `git diff --check` for whitespace checks.

Report the packages changed, validation results, commit and bookmark if created, verified push or PR status, and unrelated edits retained. State clearly when the update remains uncommitted or validation is incomplete.
