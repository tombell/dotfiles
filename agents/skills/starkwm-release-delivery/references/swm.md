# swm

Usual checkout: `/Users/tombell/Code/starkwm/swm`. Expected GitHub repository: `starkwm/swm`. Verify both against the actual checkout and remote.

## Version and validation

The inspected Makefile generates `Sources/Swm/Version.swift` from `Sources/Swm/Version.swift.tmpl`. Preserve the tag's `v` prefix in the embedded value.

For the current Makefile, run from the checkout using fish syntax:

```fish
set release_tag vX.Y.Z
make bump_version NEW_VERSION=$release_tag
make build
make lint
make test
.build/debug/swm --version
git diff --check
```

Set `release_tag` to the selected real tag. Inspect the Makefile again before execution. `make release` builds an optimized executable in `.build/release`; use it when the requested validation or artifact needs that build. If SwiftPM sandboxing prevents the build, the equivalent current debug build is `swift build --disable-sandbox`.

The current test target uses Swift Testing with `--parallel --disable-xctest` and forwards `TEST_ARGS`. An access-related rerun can use `make test TEST_ARGS=--disable-sandbox`, with required agent permissions handled separately. Focused tests can help diagnose a failure but do not replace full release validation. Read `docs/testing.md` for the current test setup.

If module caches are unwritable, create a task-specific temporary directory and pass writable `CLANG_MODULE_CACHE_PATH` and `SWIFTPM_MODULECACHE_OVERRIDE` values with fish `env` syntax. Use a SwiftPM scratch path as needed. Do not delete the user's caches. Adjust the binary path if the build used a different scratch path.

Read `Package.swift`, `docs/getting-started.md`, and CI for current platform and toolchain requirements. The package's Swift tools version has changed since older release sessions; do not reuse an old requirements sentence. CI currently delegates to `starkwm/workflows`, so inspect the referenced workflow when needed.

## Release notes and desktop checks

Use `docs/index.md` and the relevant CLI/configuration docs at the final tag for notes. Recent releases use the tag as the title and are prereleases; verify that convention live. `--version` exits without starting the window manager. Do not start the daemon just to validate a version bump, and keep any requested manual desktop testing separate from build/test evidence.
