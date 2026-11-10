# sbar

Usual checkout: `/Users/tombell/Code/starkwm/sbar`. Expected GitHub repository: `starkwm/sbar`. Verify both against the actual checkout and remote.

## Version and validation

`Sources/Sbar/Version.swift` is checked in and edited directly; there is no template or `bump_version` target. Change only the version string in `Version.current`, preserving the tag's `v` prefix. The diff should be that one line.

After the edit, run from the checkout using fish syntax:

```fish
make build
make lint
make test
.build/debug/sbar --version
git diff --check
```

Inspect the Makefile again before execution. `make release` builds an optimized executable in `.build/release`; use it when the requested validation or artifact needs that build. If SwiftPM sandboxing prevents the build, the equivalent current debug build is `swift build --disable-sandbox`.

The current test target uses Swift Testing with `--no-parallel --disable-xctest`. It does not forward `TEST_ARGS`. For an access-related rerun, use the equivalent `swift test --no-parallel --disable-xctest --disable-sandbox` with required agent permissions handled separately.

Tests that query `BatteryProvider` have crashed under the agent sandbox's restricted macOS power-source access. Rerun an affected suite with permitted host access before classifying that crash as a regression. A full passing host-access run supplies release validation; a failed sandbox run alone does not.

For unwritable caches, use task-specific temporary `CLANG_MODULE_CACHE_PATH` and `SWIFTPM_MODULECACHE_OVERRIDE` values with fish `env` syntax, and a SwiftPM scratch path if needed. Adjust the binary path to match. Read `Package.swift`, current docs, and the referenced CI workflow for platform and toolchain requirements.

## Release notes and desktop checks

Use `docs/index.md`, configuration docs, provider docs, and the schema at the final tag to check user-facing changes. Recent releases use the tag as the title and are prereleases; verify that convention live. `--version` exits without starting the bar. Example-config validation is useful when released changes affect configuration; it is not a substitute for the test suite or proof that the desktop bar works.
