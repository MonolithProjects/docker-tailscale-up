ARG TAILSCALE_RELEASE=latest
FROM tailscale/tailscale:$TAILSCALE_RELEASE

LABEL org.opencontainers.image.authors="Michal Muransky <mike.muransky@gmail.com>"
LABEL org.opencontainers.image.url="https://github.com/monolithprojects/docker-tailscale"
LABEL org.opencontainers.image.documentation="https://github.com/monolithprojects/docker-tailscale"
LABEL org.opencontainers.image.source="https://github.com/monolithprojects/docker-tailscale"
LABEL org.opencontainers.image.title="monolithprojects/tailscale-up"
LABEL org.opencontainers.image.description="Tailscale is Wireguard made easy"

COPY . .

HEALTHCHECK --interval=30s --timeout=2s CMD tailscale ip > /dev/null || exit 1

CMD ["./tailscale.sh"]