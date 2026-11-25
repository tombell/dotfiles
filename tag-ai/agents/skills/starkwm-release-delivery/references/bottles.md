# Manual bottle recovery

Only after a failed release run, with the user's approval. This does not cover building bottles or editing formulae.

1. Download the run's artifact into a temporary directory outside any checkout: `gh run download $run_id --repo $release_repo`.
2. Run `tar -tzf` on the bottle and confirm the package, version, and platform. Record its filename, size, and SHA-256, and match it against the artifact's `SHA256SUMS`.
3. Check the release's assets. A same-named asset with matching size and digest is already attached; a different one is a conflict to report.
4. Upload it: `gh release upload $release_tag $bottle_path --repo $release_repo`.
5. Check `gh release view $release_tag --repo $release_repo --json assets,url` for the name, `uploaded` state, size, and `sha256:` digest. After an uncertain upload, inspect before retrying. Never use `--clobber` or delete an asset without approval.
