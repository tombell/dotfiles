# Brighid and Pi backups

## Nightly jobs

Both LaunchAgents run in Brighid's logged-in macOS session. After a reboot, log in and make sure the Samsung T5 is mounted and unlocked. All times below are Europe/London.

### Brighid at 03:00

- **`hem-web`** uses SQLite's online backup API inside the running container. Restic saves the copy as `/hem.sqlite` with tag `hem-web`.
- **`~/Code`** is saved with tag `code`, including Git history and working files. The exclude file at `~/.config/brighid-backup/code-excludes` lists `node_modules`, `.build`, `.cache`, `DerivedData`, `.next`, and `.venv`. Tracked `vendor` content is included.
### Pi at 06:00

- On the Pi, `rpi-pihole-export.timer` generates a Pi-hole Teleporter archive at **05:30** and stores it at `/var/lib/rpi-backup/teleporter.zip`.
- Brighid pulls the bundle over SSH using the Pi's `~/.local/bin/rpi-backup-export`. It requires a Teleporter export and a Homebridge instance backup less than 36 hours old. The restic snapshot, tagged `services`, contains `/rpi-services.tar` with `pihole/teleporter.zip`, `homebridge/backup.tar.gz`, `fr24feed/fr24feed.ini`, and `fr24feed/fr24feed.service`.

## Storage, retention, and alerts

| Job | LaunchAgent | T5 repository | B2 prefix | Alert deadline |
| --- | --- | --- | --- | --- |
| Brighid | `local.brighid-backup` | `/Volumes/T5/Restic/Brighid` | `restic/brighid/` | 04:00 |
| Pi | `local.rpi-backup` | `/Volumes/T5/Restic/rpi` | `restic/rpi/` | 07:00 |

The two encrypted restic repositories share the private B2 bucket `tombell-restic-backups` at `s3.eu-central-003.backblazeb2.com`. Each job writes to the T5, copies to B2, then applies retention to both destinations. Each source keeps every snapshot within 14 days of its newest snapshot, plus its 8 most recent weekly and 12 most recent monthly restore points.

Both B2 prefixes delete hidden object versions after 30 days. Keep **Days Till Hide** blank so live restic objects do not expire based on upload age. Each job has a separate Healthchecks.io email check for failures and missed runs. The checks receive the job result without backup contents or logs.

## Inspect or run

Run these on Brighid directly or through `fleet-exec.sh brighid`.

```fish
for job in brighid-backup rpi-backup
    launchctl print "gui/$(id -u)/local.$job"
    tail -n 60 ~/Library/Logs/$job/stdout.log ~/Library/Logs/$job/stderr.log
    ~/.local/bin/$job snapshots
    ~/.local/bin/$job-b2 snapshots
end
```

To test an idle job, run `launchctl kickstart` with its service target from above. Verify the last exit code and new log entries for the T5 snapshot, B2 copy, retention, and Healthchecks result. If the Pi job reports a stale Teleporter export, check `systemctl status rpi-pihole-export.timer` and `journalctl -u rpi-pihole-export.service` on the Pi.

## Recover without Brighid

- **T5.** Connect it to a Mac and unlock it with **Samsung T5** in 1Password. Use **T5 restic repository** for the Brighid repository and the separately saved Pi T5 password for the Pi repository.
- **B2.** Use the current bucket's key ID and application key from 1Password as `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. Use `s3:https://s3.eu-central-003.backblazeb2.com/tombell-restic-backups/restic/brighid` with **Brighid B2 restic repository** or `s3:https://s3.eu-central-003.backblazeb2.com/tombell-restic-backups/restic/rpi` with the separately saved Pi B2 restic password. Keep credential values out of command history and logs.

The Pi passwords on Brighid are at `~/.config/rpi-backup/repository-password` (T5) and `~/.config/rpi-backup/b2/repository-password` (B2). Keep independent copies in 1Password.

Use `restic -r <repository> snapshots` to choose a restore point. Run `restic -r <repository> restore <snapshot-id> --target <empty-directory> --verify` with real values in place of the placeholders. Restore to a separate directory before replacing live files. For the restored health database, verify that `sqlite3 -readonly 'file:/absolute/path/hem.sqlite?immutable=1' 'PRAGMA integrity_check;'` returns `ok`.

For the Pi, unpack the restored `rpi-services.tar` in a private directory. Import the Teleporter ZIP into Pi-hole and the Homebridge archive through Homebridge Backup & Restore. Use the Flightradar24 files to rebuild the feeder. The restored bundle may contain service credentials.

On 2026-11-27, restores from the new B2 bucket verified the `hem-web` database, a Code sample, and the Pi bundle. Importing the Pi archives into replacement services remains untested.
