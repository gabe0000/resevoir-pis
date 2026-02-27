# Reservoir Pi(s) Quickstart (Public-Safe)

## Goal
Verify the end-to-end custom query/reply lifecycle and stock MQTT compatibility using sanitized, role-based steps.

## Role Placeholders
- Edge host: `<edge-host>`
- Control host: `<control-host>`
- SSH user: `<ssh-user>`
- Broker container: `<broker-container>`

## 1) Verify edge services
Run on `<edge-host>`:
```bash
sudo docker ps --format 'table {{.Names}}\t{{.Status}}'
```

## 2) Verify control services
Run on `<control-host>`:
```bash
sudo docker ps --format 'table {{.Names}}\t{{.Status}}'
sudo systemctl status joe-cabot-lite --no-pager
```

## 3) Query custom agent topics directly
Terminal A on `<control-host>`:
```bash
sudo docker exec -it <broker-container> sh -lc 'mosquitto_sub -h <edge-broker-host> -p 1883 -t susnet/agent/reply'
```
Terminal B on `<control-host>`:
```bash
RID=$(date +%s)-$RANDOM
sudo docker exec -i <broker-container> sh -lc "mosquitto_pub -h <edge-broker-host> -p 1883 -t susnet/agent/query -m '{\"request_id\":\"'$RID'\",\"sender\":\"<sender-id>\",\"text\":\"status summary please\"}'"
```

## 4) Validate docs contract in this repo
```bash
cd <repo-root>/resevoir-pis
./scripts/validate-docs.sh
```
