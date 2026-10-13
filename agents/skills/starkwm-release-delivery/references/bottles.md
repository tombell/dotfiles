# Requested Homebrew bottle attachments

Use only when the user asks to attach an existing bottle. This does not include building a bottle, updating formulae, or releasing another project unless requested.

1. Confirm the intended repository, release tag, and exact local archive. A common location is `/Users/tombell/Code/starkwm/homebrew-formulae`, but inspect the actual files. Read checkout instructions and status if working there.
2. Run `tar -tzf` on the archive. Check that its contents describe the requested package/version and expected architecture/platform. Record its filename, size in bytes, and SHA-256 digest before upload. Do not extract into the repository.
3. Confirm that the matching GitHub Release exists and is published. Inspect existing assets. If the same filename already has matching size and digest, report it as already attached. If it differs, report the conflict rather than overwriting it.
4. Upload the selected archive, using explicit repository and tag:

```fish
gh release upload $release_tag $bottle_path --repo $release_repo
```

5. Query assets after upload with `gh release view $release_tag --repo $release_repo --json assets,url`. Require the correct name, state `uploaded`, matching size, and GitHub's `sha256:` digest. If GitHub does not supply a digest, download that exact asset to a temporary directory and compare its SHA-256 before claiming integrity is verified.
6. After a connection error or uncertain upload response, inspect assets before retrying. Do not use `--clobber` or delete an asset without explicit authorization. Report the release/asset URL and the verified digest.
