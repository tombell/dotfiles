# Projects

Each project is a `starkwm/<name>` Swift package with a checked-in `Sources/<Name>/Version.swift` (`Version.current`, including the `v` prefix) and a `release.yml` that calls the shared release workflow. Releases are prereleases titled with the tag. Validate from the checkout:

```fish
make build
make lint
make test
.build/debug/<name> --version
git diff --check
```

| Project | `--version` prints | `make test` runs | `make release` |
| --- | --- | --- | --- |
| swm | `swm version <tag>` | `swift test --parallel --disable-xctest $(TEST_ARGS)` | release build with `--disable-sandbox` |
| sbar | `sbar version <tag>` | `swift test --no-parallel --disable-xctest` | release build with `--disable-sandbox` |
| sborders | `sborders version <tag>` | `swift test --parallel --disable-xctest` | release build without `--disable-sandbox` |
| stags | `stags version <tag>` | `swift test` | none; use `swift build --configuration release --disable-sandbox` |
| skbd | `skbd <tag>` | `swift test --parallel --disable-xctest` | runs `clean`, then a release build with `--disable-sandbox` |

For a sandbox-related test rerun, add `--disable-sandbox` to the same `swift test` command (`make test TEST_ARGS=--disable-sandbox` for swm). Recheck the Makefile, since these details drift.

For notes, read `docs/index.md` and the docs for the changed areas at the final tag. `--version` exits without starting anything; do not start a daemon, restart a Homebrew service, or move the user's windows to validate a release.

## Project notes

- **sbar**: `BatteryProvider` tests have crashed under the agent sandbox's restricted power-source access. Rerun with host access before calling it a regression. Check the configuration schema and provider docs for notes.
- **sborders**: tests do not prove live WindowServer rendering.
- **stags**: tests do not prove Accessibility moves, Space transitions, or restoring parked windows.
- **skbd**: the Homebrew formula is `skbd@2` (the workflow's `formula-name`), which is not the app version. `make release` removes the debug build, so check `.build/release/skbd --version` afterwards. Releases do not touch `tree-sitter-skbdrc`.
