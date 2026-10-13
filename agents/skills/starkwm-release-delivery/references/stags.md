# stags

Usual checkout: `/Users/tombell/Code/starkwm/stags`. Expected GitHub repository: `starkwm/stags`. Verify both against the actual checkout and remote.

## Version and validation

The current version-support change generates `Sources/Stags/Version.swift` from `Sources/Stags/Version.swift.tmpl` with `make bump_version`. It rejects an empty `NEW_VERSION`. The template embeds the exact selected value, including the `v` prefix. The custom CLI prints `stags version <embedded version>` for `--version` and exits before resolving a socket path, constructing a daemon, or connecting to a socket.

Recheck the actual checkout before execution. An older revision may predate this support, and local support changes must be included in the intended release commit/range before publication.

Run the current commands from the checkout using fish syntax:

```fish
set release_tag vX.Y.Z
make bump_version NEW_VERSION=$release_tag
make build
make lint
make test
.build/debug/stags --version
git diff --check
```

Set `release_tag` from the current source, live tags, and requested version. Version support does not itself create a tag or a release.

The current lint target is strict, and `make test` invokes `swift test` without the parallel/XCTest flags used by other StarkWM tools. Preserve that current setup. An access-related rerun can use `swift test --disable-sandbox` with required agent permissions handled separately. Use writable temporary Swift/Clang caches if needed.

The Makefile currently has no `release` target. If an optimized build is requested, use `swift build --configuration release --disable-sandbox` and check the corresponding `.build/release/stags --version` output.

Read `Package.swift`, `docs/development.md`, and the referenced CI workflow for current requirements and test conventions. Automated tests do not prove live Accessibility moves, Space transitions, or restoration of parked windows. Do not start the daemon or move the user's windows just to validate a release.

## First publication

The live repository had no tags or GitHub Releases when inspected. Recheck before selecting the previous release or channel. Publishing the current untagged version does not require incrementing it unless the user asks for a new version. Use the shared StarkWM prerelease convention when no channel is specified.

Use `docs/index.md`, CLI docs, tag/view docs, and recovery docs at the final tag for notes. First-release notes should describe the project and the tagged capabilities, without a fabricated previous-release comparison. For a request to publish an existing tag, validate that revision rather than bumping or moving refs again.
