#!/usr/bin/env bash

set -euo pipefail; [[ -z ${TRACE:-} ]] || set -x

export DEBIAN_FRONTEND=noninteractive

die() {
	echo "$@"
	exit 1
}

pushd /vagrant &>/dev/null || die "Can't chdir to vagrant shared directory: /vagrant"

manifest=app.json
[[ -f $manifest ]] || die "Application manifest not found: $manifest"

application=${application:-$(jq -r '.name' "$manifest")}
operator=${operator:-$(id -rnu 1000 2>/dev/null)}

environment=/etc/vagrant/environment
mkdir -p "$(dirname "$environment")" && touch "$environment"

if [[ -d ${HOSTPATH:-} ]]; then
	hostdir=$(readlink -f "$HOSTPATH")

	cat >"$environment" <<-EOF
		BUNDLE_PATH='$hostdir/bundle'
		BUNDLE_APP_CONFIG='$hostdir/bundle'

		BOOTSNAP_CACHE_DIR='$hostdir/bootsnap'

		YARN_CACHE_FOLDER='$hostdir/yarn/cache'
		NODE_MODULES_FOLDER='$hostdir/yarn/node_modules'
	EOF
fi

if [[ -f .env ]]; then
	cat .env >>"$environment"
fi

su - "$operator" -c 'cat >>.zshrc'<<-EOF
	cd /vagrant && set -a && . "$environment" && set +a
EOF
