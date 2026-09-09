# Your own Nostr relay (strfry + Caddy)

## What you need
- A VPS (a Hetzner CX22 is plenty)
- A domain or subdomain, e.g. `relay.yourdomain.com`, with an **A record** pointing at the VPS IP

## Install (3 steps)
1. Copy this folder to the server:
   `scp -r relay-setup root@YOUR_IP:~/`
2. SSH in and run:
   `cd relay-setup && sudo bash setup.sh relay.yourdomain.com`
3. Wait ~30 seconds for the TLS certificate, then your relay is live at:
   `wss://relay.yourdomain.com`

## Hook it into the chat app
Open the chat app, tap the relay dots in the header, and add
`wss://relay.yourdomain.com`. To make it permanent, edit the RELAYS
line near the top of the app's script and put your relay first.

## Useful commands
- Logs: `docker logs -f strfry`
- Restart: `docker compose restart`
- Update: `docker compose pull && docker compose up -d`
- Full DB export (backup): `docker exec strfry strfry export > backup.jsonl`

## Notes
- The config accepts writes from anyone. For a private relay, strfry
  supports write-policy plugins to whitelist pubkeys — ask me and I'll add one.
- Event DB lives in `./strfry-db` — back it up if you care about history.
