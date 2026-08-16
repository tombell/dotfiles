# Fleet Inventory

## Addressing

All hosts are reachable by a local lowercase hostname and, when Tailscale is available, by:

```text
<hostname>.solarflare-skink.ts.net
```

Prefer the local hostname; fall back to the Tailnet FQDN. SSH usernames, ports, keys, and other credentials come from the user's SSH configuration and must not be recorded here.

## Hosts

| Name | Hostname | Platform | Role | Network | Package manager |
|---|---|---|---|---|---|
| Pyra | `pyra` | macOS, MacBook Air | Main personal computer | Primary LAN + Tailnet | Homebrew |
| Haze | `haze` | macOS, MacBook Pro | Work computer | Primary LAN + Tailnet | Homebrew |
| Brighid | `brighid` | macOS, Mac mini | AI-agent host; runs Hermes and web services | Agents VLAN + Tailnet | Homebrew |
| Mythra | `mythra` | macOS, Intel MacBook Air | Runs an Executor Docker image used as an MCP gateway for Hermes on Brighid | Agents VLAN + Tailnet | Homebrew |
| rpi | `rpi` | Raspbian, Raspberry Pi 3 Model B | Runs Homebridge and fr24 | Agents VLAN + Tailnet | apt |

## Boundaries

- Hermes owns service management on Brighid.
- Executor runs as a Docker image on Mythra.
- Homebridge and fr24 run on rpi.
- Brighid, Mythra, and rpi reside on the UniFi `Agents` VLAN.
- Service, Docker, Hermes, and UniFi/VLAN administration are outside this skill's current package-update scope.
