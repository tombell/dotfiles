# sborders

Usual checkout: `/Users/tombell/Code/starkwm/sborders`. Expected GitHub repository: `starkwm/sborders`. Verify both against the actual checkout and remote.

## Version and validation

The inspected Makefile generates `Sources/Sborders/Version.swift` from `Sources/Sborders/Version.swift.tmpl` and rejects an empty `NEW_VERSION`. The generator embeds that value literally in `Version.current`, a string used by ArgumentParser's version option.

For the current Makefile, run from the checkout using fish syntax:

```fish
set release_tag X.Y.Z
make bump_version NEW_VERSION=$release_tag
make build
make lint
make test
.build/debug/sborders --version
git diff --check
```

Replace `X.Y.Z` with the selected version, including a prefix only if that is the chosen spelling. The current source uses a bare semantic version, and the live repository had no tags or GitHub Releases when checked. Do not assume an established `v` prefix or previous release. Recheck before selecting a first-release version and channel. Publishing the current untagged version does not require incrementing it unless the user requested a new version.

The current lint target is strict. Tests use `swift test --parallel --disable-xctest`, and the Makefile does not forward `TEST_ARGS`. For an access-related test rerun, use `swift test --parallel --disable-xctest --disable-sandbox` with required agent permissions handled separately. Use writable temporary Swift/Clang caches when needed; do not alter code or dependencies to bypass access failures.

`make release` builds `.build/release/sborders` without the `--disable-sandbox` flag used by some siblings. When an optimized build is requested, run that target and check that binary's version. If SwiftPM sandboxing prevents it, the equivalent build is `swift build --configuration release --disable-sandbox`. Read `Package.swift`, `docs/development.md`, and the referenced CI workflow for current requirements and validation conventions.

## Release notes and desktop checks

Use `docs/index.md`, CLI/configuration docs, and `docs/development.md` at the final tag. For the first release, use the initial-release guidance in `github-release-notes`; there is no previous-tag compare link until a previous release exists.

`--version`, help, and configuration validation work without starting the border renderer. Build/test results do not verify live WindowServer behavior or every supported macOS version. Keep desktop checks separate, and preserve any instruction to leave them to the user.
