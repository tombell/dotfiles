## Working style

- Requests for suggestions, reviews, or plans do not authorize implementation.
- Keep changes focused on the requested work. Avoid unrelated cleanup.
- Make routine implementation decisions without asking for confirmation.

## Shell

- Use fish syntax for commands intended for me to run.
- Prefer the project's existing build commands and pinned tool versions.

## Testing

- Prefer tests of meaningful behavior over tests that mirror implementation.
- Avoid trivial tests and duplicate coverage.
- If I reserve manual testing, do not launch the app. Build, run automated
  checks, and provide a short manual test path.
- Report what was verified and what still needs manual testing.

## Delivery

- Keep commits focused and independently reviewable.
- After pushing, verify the remote refs and report the working-copy status.

## Communication

- Use plain, concise language and concrete claims.
- Explain what changed, why, and how it was verified.
- Support performance claims with measurements.

## Source control

- Use `jj` if `.jj` directory exists
- Avoid using conventional commit style commit messages, unless the project already uses that style.
