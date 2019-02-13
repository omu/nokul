#!/bin/bash

set -euo pipefail; [[ -z ${TRACE:-}  ]] || set -x

export DEBIAN_FRONTEND=noninteractive

die() {
	echo "$@"
	exit 1
}

apt-get -y update && apt-get install -y slapd ldap-utils

gem install bcrypt

[[  ! -e /var/lib/ldap/bootstrapped   ]] || { echo >&2 "Found already configured slapd"; exit 0;  }

pushd /app/lib/templates/ldap &>/dev/null

debconf-set-selections <<-EOF
	slapd slapd/password1 password 12345
	slapd slapd/password2 password 12345
	slapd slapd/no_configuration boolean false
	slapd slapd/move_old_database boolean true
	slapd slapd/domain string test.omu.edu.tr
	slapd slapd/invalid_config boolean true
	slapd shared/organization string omu
	slapd slapd/backend string MDB
	slapd slapd/purge_database boolean false
EOF

dpkg-reconfigure -f noninteractive slapd
tar -xf *.tar.gz -C /

pushd config &>/dev/null

ldapadd -Q -Y EXTERNAL -H ldapi:/// -f 01-enable-bcrypt.ldif
ldapmodify -Q -Y EXTERNAL -H ldapi:// -f 02-disallow-anon.ldif
ldapmodify -H ldapi:// -x -D "cn=admin,dc=test,dc=omu,dc=edu,dc=tr" -w 12345 -f 03-admin-normal-password.ldif
ldapmodify -Q -Y EXTERNAL -H ldapi:// -f 04-admin-config-password.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/dyngroup.ldif
ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f 05-enable-dynlist.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f 06-dynlist-dbconfig.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f schema/eduperson2016.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f schema/schac-schema-1.5.ldif

ldapadd -x -D cn=admin,dc=test,dc=omu,dc=edu,dc=tr -w 12345 -f import.ldif

touch /var/lib/ldap/bootstrapped
