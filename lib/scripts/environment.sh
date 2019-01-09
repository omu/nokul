#!/usr/bin/env bash

set -euo pipefail; [[ -z ${TRACE:-} ]] || set -x

export DEBIAN_FRONTEND=noninteractive

die() {
	echo "$@"
	exit 1
}

pushd /app &>/dev/null || die "Can't chdir to app directory: /app"

manifest=app.json
[[ -f $manifest ]] || die "Application manifest not found: $manifest"

application=${application:-$(jq -r '.name' "$manifest")}
operator=${operator:-$(id -rnu 1000 2>/dev/null)}
environment=/etc/environment

if [[ -d ${LOCAL_CACHE_DIR:-} ]]; then
	cat >"$environment" <<-EOF
		BUNDLE_PATH='$LOCAL_CACHE_DIR/bundle'
		BUNDLE_APP_CONFIG='$LOCAL_CACHE_DIR/bundle'

		BOOTSNAP_CACHE_DIR='$LOCAL_CACHE_DIR/bootsnap'

		YARN_CACHE_FOLDER='$LOCAL_CACHE_DIR/yarn/cache'
		NODE_MODULES_FOLDER='$LOCAL_CACHE_DIR/yarn/node_modules'
	EOF
fi

if [[ -f .env ]]; then
	cat .env >>"$environment"
fi
