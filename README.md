# Tailscale-up Container image

[![GitHub Actions](https://github.com/MonolithProjects/docker-tailscale-up/workflows/Build%20image/badge.svg)](https://github.com/MonolithProjects/docker-tailscale-up/actions)
[![DockerHub-pulls](https://img.shields.io/docker/pulls/monolithprojects/tailscale-up)](https://hub.docker.com/repository/docker/monolithprojects/tailscale-up)

Daily built Tailscale container image which extends the original [tailscale/tailscale](https://hub.docker.com/r/tailscale/tailscale) image by building-in a script for automatic execution of `tailscaled` and `tailscale up` CLI command (including all ["up" arguments](https://tailscale.com/kb/1080/cli/#up) as environment variables)

## Tags

- `latest`
- `stable`
- `unstable`
- `1.23`
- `1.22`
- `1.21`
- `1.20`

## Supported flags

`tailscale up` arguments can be passed as following variables.
For flags description, please check: https://tailscale.com/kb/1080/cli/#up

- ACCEPT_DNS
- ACCEPT_ROUTES
- ADVERTISE_EXIT_NODE
- ADVERTISE_ROUTES
- ADVERTISE_TAGS
- AUTHKEY
- CUSTOM_HOSTNAME
- EXIT_NODE
- EXIT_NODE_ALLOW_LAN_ACCESS
- FORCE_REAUTH
- HOST_ROUTES
- NETFILTER_MODE
- OPERATOR
- QR
- RESET
- SHIELDS_UP
- SNAT_SUBNET_ROUTES

## Example docker-compose

```yaml
version: '3'
services:
  tailscale:
    image: monolithprojects/tailscale-up:stable
    environment:
      - AUTHKEY=$AUTHKEY
      - ACCEPT_DNS=true # This can be any value as the script is evaluating only if the variable is set.
      - CUSTOM_HOSTNAME="myserver"
    volumes:
      - /dev/net/tun:/dev/net/tun
      - /var/lib/tailscale:/var/lib/tailscale
    network_mode: host
    privileged: true
    restart: unless-stopped
```

## License

MIT

## Author Information

Created in 2022 by Michal Muransky
