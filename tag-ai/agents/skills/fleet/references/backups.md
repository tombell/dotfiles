# Brighid backups

## Nightly job

The `local.brighid-backup` LaunchAgent runs at **03:00 Europe/London** in Brighid's logged-in macOS session. After a reboot, log in and make sure the Samsung T5 is mounted and unlocked.

- **`hem-web`** uses SQLite's online backup API inside the running container. Restic saves the copy as `/hem.sqlite` with tag `hem-web`.
- **`~/Code`** is saved with tag `code`, including Git history and working files. The exclude file at `~/.config/brighid-backup/code-excludes` lists `node_modules`, `.build`, `.cache`, `DerivedData`, `.next`, and `.venv`. Tracked `vendor` content is included.
- Restic writes both snapshots to `/Volumes/T5/Restic/Brighid`, then copies snapshots to the private B2 repository under `restic/brighid/`. After both backups and the copy succeed, restic applies retention on the T5 and B2. Each source keeps every snapshot within 14 days of its newest snapshot, plus its 8 most recent weekly and 12 most recent monthly restore points.
- The B2 lifecycle rule deletes hidden object versions under `restic/brighid/` after 30 days. Keep **Days Till Hide** blank so live restic objects do not expire based on upload age.
- Healthchecks.io receives the job result, without backup contents or logs. Its email check covers failures and missed runs, with a 04:00 deadline. Healthchecks is the only alert channel.

## Inspect or run

Run these on Brighid directly or through `fleet-exec.sh brighid`.

```fish
launchctl print "gui/$(id -u)/local.brighid-backup"
tail -n 60 ~/Library/Logs/brighid-backup/stdout.log ~/Library/Logs/brighid-backup/stderr.log
~/.local/bin/brighid-backup snapshots
~/.local/bin/brighid-backup-b2 snapshots
```

To test the scheduled job, run `launchctl kickstart "gui/$(id -u)/local.brighid-backup"` when it is idle. Verify the last exit code and the new log entries. A successful run creates both T5 snapshots, copies them to B2, applies retention, and logs that Healthchecks accepted the result.

## Recover without Brighid

- **T5.** Connect it to a Mac and unlock it with **Samsung T5** in 1Password. Open the restic repository at `/Volumes/T5/Restic/Brighid` with **T5 restic repository**.
- **B2.** Get the endpoint, bucket, prefix, key ID, and application key from **Brighid Backblaze B2** in 1Password. Use the repository URL `s3:https://<endpoint>/<bucket>/restic/brighid`. Supply the key ID and application key as `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in the restore process, and use **Brighid B2 restic repository** for the decryption password. Keep credential values out of command history and logs.

Use `restic -r <repository> snapshots` to choose a restore point. Run `restic -r <repository> restore <snapshot-id> --target <empty-directory> --verify` with real values in place of the placeholders. Restore to a separate directory before replacing live files. For the restored health database, verify that `sqlite3 -readonly 'file:/absolute/path/hem.sqlite?immutable=1' 'PRAGMA integrity_check;'` returns `ok`.

On 2026-11-27, the B2 copy of `hem-web` passed SQLite integrity verification after a restore. A separate B2 Code sample restore on Pyra succeeded with only the saved 1Password items, without Brighid or the T5.
