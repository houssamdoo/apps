```bash
curl -L https://downloads.portainer.io/ce-lts/portainer-agent-stack.yml -o portainer-agent-stack.yml
```
```bash
docker image pull portainer/agent:lts
docker image pull portainer/portainer-ce:lts
```
```bash
docker stack deploy -c portainer-agent-stack.yml portainer
```
