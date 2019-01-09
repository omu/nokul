#!/usr/bin/env bash

set -euo pipefail; [[ -z ${TRACE:-} ]] || set -x

export DEBIAN_FRONTEND=noninteractive

if [[ -d /vagrant ]] && [[ ! -e /app ]]; then
	ln -sf /vagrant /app
fi

apt-get update -y
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb
dpkg -i wkhtmlto* 2>/dev/null || true
rm -f wkhtmlto*
apt-get install -y --fix-broken
