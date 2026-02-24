# Reservoir Pi(s) Quickstart

## Goal
Verify the distributed front-desk path end to end.

## Hosts
- MeshBox edge: `100.124.168.35`
- Susnet control: `100.90.138.26`

## 1) Verify edge services on MeshBox
```bash
ssh gabe0000@100.124.168.35
sudo docker compose -f ~/meshbox/compose/meshbox-core/docker-compose.yml ps meshtastic_bridge mosquitto nodered
```

## 2) Verify control services on Susnet
```bash
ssh gabe0000@100.90.138.26
sudo systemctl status joe-cabot-lite --no-pager
sudo docker ps --format "table {{.Names}}\t{{.Status}}" | grep -E "openclaw|ollama|mosquitto"
```

## 3) Observe control lifecycle topics
```bash
ssh gabe0000@100.124.168.35
sudo docker exec mosquitto mosquitto_sub -h localhost -t "susnet/agent/#" -v
```

## 4) Send a correlated query
```bash
ssh gabe0000@100.124.168.35
RID="$(date +%s)-$RANDOM"
TS="$(date +%s)"
EXP="$((TS+120))"
sudo docker exec mosquitto mosquitto_pub -h localhost -t susnet/agent/query -m "{\"request_id\":\"$RID\",\"session_id\":\"sess-$RID\",\"text\":\"what is 2+2\",\"sender\":{\"node_id\":\"!9e77f1a0\",\"shortname\":\"GETB\",\"longname\":\"GETB\"},\"channel_index\":1,\"origin\":\"meshtastic\",\"created_ts\":$TS,\"expires_ts\":$EXP,\"trace\":{\"edge_host\":\"meshbox\",\"control_host\":\"susnet\",\"version\":\"quickstart\"}}"
```

## 5) Expected lifecycle
- `susnet/agent/ack`
- `susnet/agent/progress` with `queued` and `started`
- optional `susnet/agent/progress` with `still_working`
- `susnet/agent/reply`
- `susnet/agent/progress` with `completed`

## 6) Timeout classes
- no ack by 7s means unreachable path
- ack but no final by 30s means busy timeout

## 7) Validate canonical docs
```bash
cd ~/sync-work/resevoir-pis-sync
./scripts/validate-docs.sh
```
