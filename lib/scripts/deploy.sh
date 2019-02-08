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
[[ -f Procfile  ]] || die 'No Procfile found'

application=${application:-$(jq -r '.name' "$manifest")}
operator=${operator:-$(id -rnu 1000 2>/dev/null)}
environment=/etc/environment

if [[ -f $environment ]]; then
	set -a
	# shellcheck disable=1090
	. "$environment"
	set +a
else
	touch "$environment"
fi

systemctl enable --now postgresql
systemctl enable --now redis-server

sudo -EH -u postgres psql <<-EOF
	CREATE USER $application WITH ENCRYPTED PASSWORD '$application';
	ALTER ROLE $application LOGIN CREATEDB SUPERUSER;
EOF

sudo -EH -u "$operator" sh -xs <<-'EOF'
	bundle install -j4 --path "${BUNDLE_PATH:-vendor/bundle}"

	# XXX: ./node_modules seems to be an almost constant location. The ugly
	# kludge below applies a brute force solution for using a different
	# node_modules path (via NODE_MODULES_FOLDER environment variable)
	# without playing with (buggy or unsupported) configuration settings.

	# Overwrite existing node_modules if it's a symlink
	[[ -z $NODE_MODULES_FOLDER ]] || [[ ! -L node_modules ]] || ln -sf "$NODE_MODULES_FOLDER" node_modules

	# Avoid creating a node_modules symlink if a node_module file/directory already exists
	[[ -z $NODE_MODULES_FOLDER ]] || [[ -e node_modules   ]] || ln -s  "$NODE_MODULES_FOLDER" node_modules

	yarn install

	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:seed
EOF
