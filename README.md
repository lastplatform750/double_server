# Muh server

Current setup:
- gateway (pi): alpine
- server (dl): alpine

Current apps:
- anki sync
- jellyfin
- paperless
- qbittorrent
- navidrome
- immich
- beets
- m2 web ui

Todo:
- fix beets
- more robust package handling (remove no longer needed packages)
- fix lint errors
- setup dcron
- bazzite stuff
- rocknix stuff
- more robust backup/monitoring system
- https/reverse proxy
- forgejo(?)
- explore other image server options
- more hardening (apparmor?)
- build VMs?

## Setup

### On gateway (pi)
- install alpine (from usb or can flash directly to sd card)
- (if not already existent): make keypair on tk: `ssh-keygen` \
    **Note:** do NOT set the name of the keypair, let it be default
- copy keypair over: `ssh-copy-id rasp@pi`
- add "permit nopass rasp" to /etc/doas.conf \
    **Note:** make sure there is NOTHING in the /etc/doas.d folder
- Install python: `doas apk add python3`
- Run gateway playbook: `ansible-playbook ./hosts/gateway/playbook.yml`
- (Optional) Run dwl playbook for desktop: `ansible-playbook ./hosts/gateway/dwl_pb.yml`

### On server (dl)
- plug ethernet cable from gateway to server
- (On live installer) **Before running alpine-setup** connect to internet via ethernet connection: \
`ip link set eth0 up` \
`ip addr flush dev eth0` \
`ip addr add 192.168.50.2/24 dev eth0` \
`ip route replace default via 192.168.50.1 dev eth0`
- run `alpine-setup`
- copy keypair over: `ssh-copy-id [user]@dl`
- add "permit nopass [user]" to /etc/doas.conf \
    **Note:** make sure there is NOTHING in the /etc/doas.d folder
- Install python: `doas apk add python3`
- **DOUBLE CHECK:** The "zfs_pool_devices" in server_vars.yml is correct
- Run server playbook: `ansible-playbook ./hosts/server/playbook.yml`
- qbittorrent: on initial setup temp password is written to a text file on the machine running ansible

