# Fleet backups

## Daily jobs

The Brighid and Pi backup jobs run in Brighid's logged-in macOS session. After a reboot, log in and make sure the Samsung T5 is mounted and unlocked. Their schedules use Europe/London.

### Brighid at 03:00

- **`hem-web`** uses SQLite's online backup API inside the running container. Restic saves the copy as `/hem.sqlite` with tag `hem-web`.
- **`~/Code`** is saved with tag `code`, including Git history and working files. The exclude file at `~/.config/brighid-backup/code-excludes` lists `node_modules`, `.build`, `.cache`, `DerivedData`, `.next`, and `.venv`. Tracked `vendor` content is included.

### Pi at 06:00

- On the Pi, `rpi-pihole-export.timer` generates a Pi-hole Teleporter archive at **05:30** and stores it at `/var/lib/rpi-backup/teleporter.zip`.
- Brighid pulls the bundle over SSH using the Pi's `~/.local/bin/rpi-backup-export`. It requires a Teleporter export and a Homebridge instance backup less than 36 hours old. The restic snapshot, tagged `services`, contains `/rpi-services.tar` with `pihole/teleporter.zip`, `homebridge/backup.tar.gz`, `fr24feed/fr24feed.ini`, and `fr24feed/fr24feed.service`.

### Pyra at 18:00 and 19:00 local time

Pyra runs two independent jobs from its logged-in macOS session. At **18:00** it backs up directly to B2 and can run away from home with internet access. At **19:00** it backs up to Brighid's T5 over SFTP. The T5 job requires `brighid.local` to be reachable, unattended SSH authentication, and the T5 to be mounted and unlocked.

- The snapshot, tagged `pyra`, contains `~/Code`, `~/.dotfiles`, `~/.laptop`, and the selected app configuration listed in `~/.local/bin/pyra-backup`.
- `~/.config/pyra-backup/excludes` lists the same generated directories as Brighid. The job skips cloud-only files. Desktop, Rekordbox, Photos, iCloud Documents, and Downloads are outside its scope.

## Storage, retention, and alerts

| Job | LaunchAgent | T5 repository | B2 prefix | Alert deadline |
| --- | --- | --- | --- | --- |
| Brighid | `local.brighid-backup` | `/Volumes/T5/Restic/Brighid` | `restic/brighid/` | 04:00 |
| Pi | `local.rpi-backup` | `/Volumes/T5/Restic/rpi` | `restic/rpi/` | 07:00 |
| Pyra B2 | `local.pyra-backup` | — | `restic/pyra/` | — |
| Pyra T5 | `local.pyra-backup-t5` | `/Volumes/T5/Restic/Pyra` | — | — |

The three encrypted restic repositories share the private B2 bucket `tombell-restic-backups` at `s3.eu-central-003.backblazeb2.com`. The Brighid and Pi jobs apply retention on both destinations after the B2 copy succeeds. Each Pyra job applies retention to its own repository after a successful backup. Each source keeps every snapshot within 14 days of its newest snapshot, plus its 8 most recent weekly and 12 most recent monthly restore points.

All three B2 prefixes delete hidden object versions after 30 days. Keep **Days Till Hide** blank so live restic objects do not expire based on upload age. Brighid and the Pi have separate Healthchecks.io email checks for failures and missed runs. The checks receive the job result without backup contents or logs. Pyra reports through its local launchd status and logs.

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

Run these on Pyra.

```fish
for job in pyra-backup pyra-backup-t5
    launchctl print "gui/$(id -u)/local.$job"
    tail -n 60 ~/Library/Logs/$job/stdout.log ~/Library/Logs/$job/stderr.log
end
~/.local/bin/pyra-backup snapshots
~/.local/bin/pyra-backup --t5 snapshots
```

To test an idle job, run `launchctl kickstart` with its service target from above. Verify the last exit code, new snapshots, and retention log. For Brighid and the Pi, also verify the B2 copy and Healthchecks result. If the Pi job reports a stale Teleporter export, check `systemctl status rpi-pihole-export.timer` and `journalctl -u rpi-pihole-export.service` on the Pi.

## Recover on another machine

Connect the T5 to a Mac and unlock it with **Samsung T5** in 1Password. Use the repository password for the machine and destination you want to restore.

| Machine | T5 path | T5 1Password item | B2 prefix | B2 1Password item |
| --- | --- | --- | --- | --- |
| Brighid | `/Volumes/T5/Restic/Brighid` | **Brighid T5 restic repository** (formerly **T5 restic repository**) | `restic/brighid/` | **Brighid B2 restic repository** |
| Pi | `/Volumes/T5/Restic/rpi` | **Pi T5 restic repository** | `restic/rpi/` | **Pi B2 restic repository** |
| Pyra | `/Volumes/T5/Restic/Pyra` | **Pyra T5 restic repository** | `restic/pyra/` | **Pyra B2 restic repository** |

For B2, use the saved application key ID and application key that grant read access to the chosen prefix as `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. The repository URL is `s3:https://s3.eu-central-003.backblazeb2.com/tombell-restic-backups/restic/<host>`, with `brighid`, `rpi`, or `pyra` as the host. Keep credential values out of command history and logs.

The Pi's automated job reads its passwords on Brighid from `~/.config/rpi-backup/repository-password` (T5) and `~/.config/rpi-backup/b2/repository-password` (B2). Pyra reads its T5 password from `~/.config/pyra-backup/t5/repository-password`.

Use `restic -r <repository> snapshots` to choose a restore point. Run `restic -r <repository> restore <snapshot-id> --target <empty-directory> --verify` with real values in place of the placeholders. Restore to a separate directory before replacing live files. For the restored health database, verify that `sqlite3 -readonly 'file:/absolute/path/hem.sqlite?immutable=1' 'PRAGMA integrity_check;'` returns `ok`.

For the Pi, unpack the restored `rpi-services.tar` in a private directory. Import the Teleporter ZIP into Pi-hole and the Homebridge archive through Homebridge Backup & Restore. Use the Flightradar24 files to rebuild the feeder. The restored bundle may contain service credentials.

On 2026-11-27, restores from B2 verified Brighid's `hem-web` database and a Code sample, the Pi bundle, and a Pyra Code sample. A restore from Pyra’s T5 snapshot `175d4ddc` also verified a dotfiles README byte for byte. Importing the Pi archives into replacement services remains untested.
