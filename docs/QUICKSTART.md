# Reservoir Pi(s) Quickstart

## Goal
Use this quick guide to verify the distributed agent path end-to-end.

## Hosts
- MeshBox edge: `meshbox`
- Susnet control plane: `susnet`

## 1) Verify edge services on MeshBox
```bash
ssh codex@meshbox
sudo docker ps --format 'table {{.Names}}\t{{.Status}}'
```
Expect at minimum:
- `meshtastic_bridge`
- `mosquitto`
- `nodered`

## 2) Verify control services on Susnet
```bash
ssh codex@susnet
sudo docker ps --format 'table {{.Names}}\t{{.Status}}' | grep -E 'openclaw|ollama|mosquitto'
sudo systemctl status joe-cabot-lite --no-pager
```

## 3) Query Joe Cabot directly from SSH terminal
Terminal A:
```bash
ssh codex@susnet
sudo docker exec -it susnet-next-mosquitto sh -lc 'mosquitto_sub -h meshbox -p 1883 -t susnet/agent/reply'
```
Terminal B:
```bash
ssh codex@susnet
RID=$(date +%s)-$RANDOM
sudo docker exec -i susnet-next-mosquitto sh -lc "mosquitto_pub -h meshbox -p 1883 -t susnet/agent/query -m '{\"request_id\":\"$RID\",\"sender\":\"!9e77f1a0\",\"text\":\"traffic load summary please\"}'"
```

## 4) Validate docs contract in this repo
```bash
cd /home/gabe0000/wave1/resevoir-pis
./scripts/validate-docs.sh
```
