# stags

Use the requested checkout for `starkwm/stags`. Verify the actual checkout and remote before using the commands below.

## Version and validation

`Sources/Stags/Version.swift` is checked in and edited directly; there is no template or `bump_version` target. Change only the version string in `Version.current`, preserving the tag's `v` prefix. The diff should be that one line. The custom CLI prints `stags version <embedded version>` for `--version` and exits before resolving a socket path, constructing a daemon, or connecting to a socket.

Recheck the actual checkout before execution.

Run the current commands from the checkout using fish syntax:

```fish
make build
make lint
make test
.build/debug/stags --version
git diff --check
```

Select the version from the current source, live tags, and requested version. Version support does not itself create a tag or a release.

The current lint target is strict, and `make test` invokes `swift test` without the parallel/XCTest flags used by other StarkWM tools. Preserve that current setup. An access-related rerun can use `swift test --disable-sandbox` with required agent permissions handled separately. Use writable temporary Swift/Clang caches if needed.

The Makefile currently has no `release` target. If an optimized build is requested, use `swift build --configuration release --disable-sandbox` and check the corresponding `.build/release/stags --version` output.

Read `Package.swift`, `docs/development.md`, and the referenced CI workflow for current requirements and test conventions. Automated tests do not prove live Accessibility moves, Space transitions, or restoration of parked windows. Do not start the daemon or move the user's windows just to validate a release.

## Release history

Read live tags and GitHub Releases before selecting the previous release or channel. Publishing an already committed, untagged version does not require incrementing it unless the user asks for a new version. Follow the project's current channel, or use the shared StarkWM prerelease convention for a first publication when no channel is specified.

Use `docs/index.md`, CLI docs, tag/view docs, and recovery docs at the final tag for notes. First-release notes should describe the project and the tagged capabilities, without a fabricated previous-release comparison. For a request to publish an existing tag, validate that revision rather than bumping or moving refs again.
