#!/usr/bin/env bash
set -eo pipefail

if [ -n "${KUBE_CONFIG_B64}" ]; then
	echo -n "${KUBE_CONFIG_B64}" | base64 -d >/home/k8susr/.kube/config
	chmod 600 /home/k8susr/.kube/config
fi

if [ ! -f /home/k8susr/.kube/config ]; then
	echo "Please mount your kubeconfig file to /.kube or pass it as base64 to environment variable KUBE_CONFIG_B64"
	exit 1
else
	exec "$@"
fi
