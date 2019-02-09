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

if [[ -d ${deploy_cache_dir:-} ]]; then
	LOCAL_CACHE_DIR_BUNDLE=$deploy_cache_dir/bundle
	LOCAL_CACHE_DIR_BOOTSNAP=$deploy_cache_dir/bootsnap
	LOCAL_CACHE_DIR_YARN=$deploy_cache_dir/yarn

	cat >"$environment" <<-EOF
		LOCAL_CACHE_DIR_BUNDLE=$LOCAL_CACHE_DIR_BUNDLE
		LOCAL_CACHE_DIR_BOOTSNAP=$LOCAL_CACHE_DIR_BOOTSNAP
		LOCAL_CACHE_DIR_YARN=$LOCAL_CACHE_DIR_YARN

		BUNDLE_PATH=$LOCAL_CACHE_DIR_BUNDLE
		BUNDLE_APP_CONFIG=$LOCAL_CACHE_DIR_BUNDLE

		BOOTSNAP_CACHE_DIR=$LOCAL_CACHE_DIR_BOOTSNAP

		YARN_CACHE_FOLDER=$LOCAL_CACHE_DIR_YARN/cache
		NODE_MODULES_FOLDER=$LOCAL_CACHE_DIR_YARN/node_modules
	EOF
fi

if [[ -f .env ]]; then
	cat .env >>"$environment"
fi
