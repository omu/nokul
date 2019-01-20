#!/usr/bin/env bash

set -euo pipefail; [[ -z ${TRACE:-} ]] || set -x

export DEBIAN_FRONTEND=noninteractive

if [[ -d /vagrant ]] && [[ ! -e /app ]]; then
	ln -sf /vagrant /app
fi
