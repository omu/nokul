#!/usr/bin/env bash

set -euo pipefail; [[ -z ${TRACE:-} ]] || set -x

die() {
	echo "$@"
	exit 1
}

manifest=app.json
[[ -f $manifest  ]] || die "Application manifest not found: $manifest"
[[ -f Procfile   ]] || die 'No Procfile found'
[[ -f Dockerfile ]] || die 'No Dockerfile found'

application=${application:-$(jq -r '.name' "$manifest")}
operator=${operator:-$(id -rnu 1000 2>/dev/null)}
domain=local.omu.sh
remote=dokku
paas_environment=${paas_environment:-development}

vagrant status --machine-readable | grep -q ',metadata,provider,virtualbox' || die 'Only virtualbox supported'
command -v direnv &>/dev/null || die 'Please install and setup direnv(1).'
[[ -r ~/.ssh/id_rsa.pub ]] || die 'You need an ssh public key: ~/.ssh/id_rsa.pub'
[[ -n ${RAILS_MASTER_KEY:-} ]] || die 'You need to set environment variable: RAILS_MASTER_KEY'
echo "$application" | grep -q -E '^[a-zA-Z0-9_-]+$' || die "Malformed application name: $application"

git remote remove "$remote" &>/dev/null || true
git remote add "$remote" "dokku@${domain}:${application}"

vagrant ssh paas -- 'sudo -E bash -s' <<-SCRIPT
	dokku domains:set-global "$domain"
	echo "$domain" >/home/dokku/HOSTNAME

	dokku --force apps:destroy "$application" &>/dev/null || true
	dokku apps:create "$application"
	echo -e "web=1\\nworker=1" >/home/dokku/$application/DOKKU_SCALE

	dokku postgres:create $application-database &>/dev/null || true
	dokku postgres:link $application-database $application

	dokku redis:create $application-redis &>/dev/null || true
	dokku redis:link $application-redis $application

	dokku docker-options:add $application build '--build-arg RAILS_ENV=$paas_environment'
	dokku docker-options:add $application build '--build-arg RAILS_MASTER_KEY=$RAILS_MASTER_KEY'
	dokku config:set $application RAILS_ENV=$paas_environment RAILS_MASTER_KEY=$RAILS_MASTER_KEY

	dokku ssh-keys:remove $operator &>/dev/null || true
SCRIPT
vagrant ssh paas -- "sudo dokku ssh-keys:add $operator" <~/.ssh/id_rsa.pub &>/dev/null

curl -fsSL https://raw.githubusercontent.com/dokku/dokku/master/contrib/dokku_client.sh >bin/dokku
chmod +x bin/dokku

direnv allow . &>/dev/null

branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
if [[ $branch = master ]]; then
	refspec=master
else
	refspec=$branch:master
fi

cat >&2 <<-DOCUMENT
	PaaS setup completed.

	    Browse          http://${application}.${domain}
	    Push            git push $remote $refspec
	    Manage          dokku
	    Environment     $paas_environment
DOCUMENT
