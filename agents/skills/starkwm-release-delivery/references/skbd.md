# skbd

Usual checkout: `/Users/tombell/Code/starkwm/skbd`. Expected GitHub repository: `starkwm/skbd`. Verify both against the actual checkout and remote.

## Version and validation

`Sources/Skbd/Version.swift` is checked in and edited directly; there is no template or `bump_version` target. Change only the version string in `Version.current`, preserving the chosen spelling. The diff should be that one line. The source and published tags use a `v` prefix. The custom version path prints `skbd <embedded version>`, which differs from the `swm version ...` and `sbar version ...` wording.

After the edit, run from the checkout using fish syntax:

```fish
make build
make lint
make test
.build/debug/skbd --version
git diff --check
```

Inspect the Makefile again before execution. Tests use `swift test --parallel --disable-xctest`, and the target does not forward `TEST_ARGS`. For an access-related rerun, use `swift test --parallel --disable-xctest --disable-sandbox` with required agent permissions handled separately. Use writable temporary Swift/Clang caches when needed.

`make release` depends on `clean`, then builds an optimized executable with `--disable-sandbox`. It can remove the debug binary and prior test build products. After that target, check `.build/release/skbd --version`; do not use a stale debug path or assume `--skip-build` tests can still run. Read `Package.swift`, `docs/development.md`, and the referenced CI workflow for current requirements and conventions.

## Release notes and follow-ups

Recent GitHub Releases use the tag as the title and are prereleases. Verify that convention live. Remote `main` is ahead of the latest released tag, so publishing or verifying an existing release must not require moving main back to that tag. For a new release, use the actual current release diff, not only the version bump.

Use `docs/index.md`, CLI/configuration docs, and key-binding docs at the final tag. `--version` exits before acquiring the single-instance lock, loading configuration, or creating an event tap. Do not start the daemon or restart a Homebrew service just to validate a release.

When separately requested, the website entrypoint is `content/skbd/_index.md`. The existing Homebrew formula is named `Formula/skbd@2.rb`; its name is not the application release version. Bottle attachment requests do not authorize formula edits, service changes, or updates to the separate `tree-sitter-skbdrc` repository.
