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

command -v bundle &>/dev/null || gem install bundler

systemctl enable --now postgresql
systemctl enable --now redis-server

sudo -EH -u postgres psql <<-EOF
	CREATE USER $application WITH ENCRYPTED PASSWORD '$application';
	ALTER ROLE $application LOGIN CREATEDB SUPERUSER;
EOF

sudo -EH -u "$operator" sh -xs <<-'EOF'
	bundle install -j4 --path "${BUNDLE_PATH:-vendor/bundle}"

	[ -z $NODE_MODULES_FOLDER ] || yarn config set -- --modules-folder "$NODE_MODULES_FOLDER"
	yarn install

	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:seed
EOF

gem install foreman

foreman export -p3000 --app "$application" --user "$operator" --env /etc/environment systemd /etc/systemd/system/
systemctl enable --now "$application".target
