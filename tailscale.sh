#!/bin/sh

tailscale_cmd='tailscale up'

if [[ -n "${ACCEPT_DNS}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: ACCEPT_DNS enabled"
  tailscale_cmd="${tailscale_cmd} --accept-dns"
fi

if [[ -n "${ACCEPT_ROUTES}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: ACCEPT_ROUTES enabled"
  tailscale_cmd="${tailscale_cmd} --accept-routes"
fi

if [[ -n "${ADVERTISE_EXIT_NODE}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: ADVERTISE_EXIT_NODE enabled"
  tailscale_cmd="${tailscale_cmd} --advertise-exit-node"
fi

if [[ -n "${ADVERTISE_ROUTES}" ]]; then
  echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
  echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
  sysctl -p /etc/sysctl.d/99-tailscale.conf
  echo $(date +"%Y/%m/%d %T") "Tailscale: ADVERTISE_ROUTES provided"
  tailscale_cmd="${tailscale_cmd} --advertise-routes=${ADVERTISE_ROUTES}"
fi

if [[ -n "${ADVERTISE_TAGS}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: ADVERTISE_TAGS provided"
  tailscale_cmd="${tailscale_cmd} --advertise-tags=${ADVERTISE_TAGS}"
fi

if [[ -n "${AUTHKEY}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: AUTHKEY provided"
  tailscale_cmd="${tailscale_cmd} --authkey=${AUTHKEY}"
fi

if [[ -n "${CUSTOM_HOSTNAME}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: CUSTOM_HOSTNAME $CUSTOM_HOSTNAME provided"
  tailscale_cmd="${tailscale_cmd} --hostname=${CUSTOM_HOSTNAME}"
fi

if [[ -n "${EXIT_NODE}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: EXIT_NODE enabled"
  tailscale_cmd="${tailscale_cmd} --exit-node=${EXIT_NODE}"
fi

if [[ -n "${EXIT_NODE_ALLOW_LAN_ACCESS}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: EXIT_NODE_ALLOW_LAN_ACCESS enabled"
  tailscale_cmd="${tailscale_cmd} --exit-node-allow-lan-access"
fi

if [[ -n "${FORCE_REAUTH}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: FORCE_REAUTH enabled"
  tailscale_cmd="${tailscale_cmd} --force-reauth"
fi

if [[ -n "${HOST_ROUTES}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: HOST_ROUTES enabled"
  tailscale_cmd="${tailscale_cmd} --host-routes"
fi

if [[ -n "${NETFILTER_MODE}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: NETFILTER_MODE provided"
  tailscale_cmd="${tailscale_cmd} --netfilter-mode=${NETFILTER_MODE}"
fi

if [[ -n "${OPERATOR}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: OPERATOR $OPERATOR provided"
  tailscale_cmd="${tailscale_cmd} --operator=${OPERATOR}"
fi

if [[ -n "${QR}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: QR enabled"
  tailscale_cmd="${tailscale_cmd} --qr"
fi

if [[ -n "${RESET}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: RESET enabled"
  tailscale_cmd="${tailscale_cmd} --reset"
fi

if [[ -n "${SHIELDS_UP}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: SHIELDS_UP enabled"
  tailscale_cmd="${tailscale_cmd} --shields-up"
fi

if [[ -n "${SNAT_SUBNET_ROUTES}" ]]; then
  echo $(date +"%Y/%m/%d %T") "Tailscale: SNAT_SUBNET_ROUTES enabled"
  tailscale_cmd="${tailscale_cmd} --snat-subnet-routes"
fi

eval ${tailscale_cmd} 2>&1 &
tailscaled
