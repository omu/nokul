#!/bin/bash
# shellcheck disable=SC2016 disable=SC1117

set -euo pipefail; [[ -z ${TRACE:-}  ]] || set -x

export DEBIAN_FRONTEND=noninteractive

if [[ ! -f /etc/apt/sources.list.d/lemonldap-ng.list ]]; then
	cat >/etc/apt/sources.list.d/lemonldap-ng.list <<-EOF
		deb     https://lemonldap-ng.org/deb 2.0 main
	EOF
	curl -fsSL https://lemonldap-ng.org/_media/rpm-gpg-key-ow2 | apt-key add -

	apt-get -y update
fi

ufw disable

apt-get -y install lemonldap-ng \
	lemonldap-ng-fastcgi-server \
	lemonldap-ng-doc \
	perlmagick \
	liblasso-perl \
	libio-string-perl \
	libxml-libxslt-perl \
	libxml-simple-perl \
	libunicode-string-perl \
	libsoap-lite-perl \
	libregexp-common-perl \
	libnet-ldap-perl \
	libmime-tools-perl \
	libgd-securityimage-perl \
	libemail-sender-perl \
	libdigest-hmac-perl \
	libdbi-perl \
	libredis-perl \
	libstring-random-perl \
	libapache-session-browseable-perl \
	libcgi-emulate-psgi-perl \
	libcgi-compile-perl \
	cpanminus

sed -i 's/example\.com/sso\.vagrant\.ga/g' /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-1.json
sed -i 's/^;checkTime.*/checkTime = 1/' /etc/lemonldap-ng/lemonldap-ng.ini
sed -i 's/^logLevel.*/logLevel=debug/' /etc/lemonldap-ng/lemonldap-ng.ini

# allow sso vagrant ip for reload
# shellcheck disable=SC2117
sed -i '/^\s*location\s*=\s*[/]reload\>/a\    allow 10.0.3.19;' /etc/nginx/sites-available/handler-nginx.conf

# for vagrant
ln -s /vagrant/lib/templates/sso/etc/nginx/dhparam.pem /etc/nginx/dhparam.pem
ln -s /vagrant/lib/templates/sso/etc/nginx/snippets/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
ln -s /vagrant/lib/templates/sso/etc/nginx/portal-nginx.conf /etc/nginx/sites-enabled/

ln -s /etc/nginx/sites-available/handler-nginx.conf /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/manager-nginx.conf /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/test-nginx.conf /etc/nginx/sites-enabled/

systemctl restart lemonldap-ng-fastcgi-server
systemctl restart nginx

systemctl enable redis-server
systemctl start redis-server

cpanm Apache::Session::Redis

ln -s /usr/share/lemonldap-ng/bin/lemonldap-ng-cli /usr/local/bin

# CSP Configuration
lemonldap-ng-cli -yes 1 set \
	cspDefault "'self' https://other.vagrant.ga:3000" \
	cspImg "'self' https://other.vagrant.ga:3000" \
	cspScript "'self' https://other.vagrant.ga:3000" \
	cspStyle "'self' https://other.vagrant.ga:3000" \
	cspFont "'self' https://other.vagrant.ga:3000" \
	cspFormAction "'self' https://other.vagrant.ga:3000" \
	cspConnect "'self' https://other.vagrant.ga:3000"

# security
lemonldap-ng-cli -yes 1 set portalAntiFrame '0'

# register
lemonldap-ng-cli -yes 1 set registerUrl "https://other.vagrant.ga:3000/activation"

# Reload Configuration
lemonldap-ng-cli -yes 1 delKey reloadUrls localhost
lemonldap-ng-cli -yes 1 addKey reloadUrls 'reload.sso.vagrant.ga' 'http://reload.sso.vagrant.ga/reload'

# Session Storage Configuration
lemonldap-ng-cli -yes 1 delKey globalStorageOptions Directory persistentStorageOptions LockDirectory
lemonldap-ng-cli -yes 1 set globalStorage 'Apache::Session::Browseable::Redis'
lemonldap-ng-cli -yes 1 addKey globalStorageOptions 'server' '127.0.0.1:6379'

# LDAP configuration
lemonldap-ng-cli -yes 1 set \
	authentication 'LDAP' \
	passwordDB 'LDAP' \
	registerDB 'Null' \
	ldapServer 'ldap://ldap.vagrant.ga' \
	ldapPort 389 \
	ldapBase 'dc=acme,dc=omu,dc=sh' \
	managerDn 'cn=admin,dc=acme,dc=omu,dc=sh' \
	managerPassword '12345' \
	AuthLDAPFilter '(&(uid=$user)(objectClass=eduPerson))' \
	mailLDAPFilter '(&(mail=$mail)(objectClass=eduPerson))'

# LDAP Exported Vars
lemonldap-ng-cli -yes 1 addKey \
	ldapExportedVars uid uid \
	ldapExportedVars cn cn \
	ldapExportedVars sn sn \
	ldapExportedVars mobile mobile \
	ldapExportedVars mail mail \
	ldapExportedVars givenName givenName

# manager portal auth config
lemonldap-ng-cli -yes 1 addKey \
	'locationRules/manager.sso.vagrant.ga' 'default' '$uid eq "cezmi"' \
	'locationRules/manager.sso.vagrant.ga' '(?#Sessions)/(.*?\.(fcgi|psgi)/)?sessions' '$uid eq "cezmi"' \
	'locationRules/manager.sso.vagrant.ga' '(?#Configuration)^/(.*?\.(fcgi|psgi)/)?(manager\.html|confs/|$)' '$uid eq "cezmi"' \
	'locationRules/manager.sso.vagrant.ga' '(?#Notifications)/(.*?\.(fcgi|psgi)/)?notifications' '$uid eq "cezmi"'

# OIDC configuration
lemonldap-ng-cli -yes 1 set \
	issuerDBOpenIDConnectActivation 1 \
	oidcServiceMetaDataIssuer 'https://auth.sso.vagrant.ga' \
	oidcServicePrivateKeySig "$(cat /vagrant/lib/templates/sso/etc/oidc.key)" \
	oidcServicePublicKeySig "$(cat /vagrant/lib/templates/sso/etc/oidc_pub.key)" \
	oidcServiceKeyIdSig "$(genpasswd)" \
	oidcServiceAllowHybridFlow 1 \
	oidcServiceAllowAuthorizationCodeFlow 1 \
	oidcServiceAllowImplicitFlow 1

# OIDC RP configuration
# Nokul
lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataExportedVars/nokul email mail \
        oidcRPMetaDataExportedVars/nokul family_name sn \
        oidcRPMetaDataExportedVars/nokul name cn \
        oidcRPMetaDataExportedVars/nokul sub uid

lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsClientID testclientid \
        oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsClientSecret testclientsecret

lemonldap-ng-cli -yes 1 addKey \
	oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsDisplayName 'Nokul' \
	oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsRedirectUris 'https://other.vagrant.ga:3000/users/auth/openid_connect/callback' \
    oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsPostLogoutRedirectUris 'https://other.vagrant.ga:3000' \
	oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsLogoutUrl 'https://other.vagrant.ga:3000/logout' \
	oidcRPMetaDataOptions/nokul oidcRPMetaDataOptionsLogoutType 'front'

# Portal customization
STATIC_DIR=/usr/share/lemonldap-ng/portal/htdocs/static
TEMPLATE_DIR=/usr/share/lemonldap-ng/portal/templates

# static data
mkdir -p $STATIC_DIR/acme/images
pushd $STATIC_DIR/acme
cp -a $STATIC_DIR/bootstrap/js/ $STATIC_DIR/acme
cp -a $STATIC_DIR/bootstrap/css/ $STATIC_DIR/acme
ln -s /vagrant/plugins/tenant/acme/app/assets/images/logos/acme-logo.svg $STATIC_DIR/acme/images/acme-logo.svg

ln -s /vagrant/plugins/tenant/acme/app/assets/images/backgrounds/background.jpg /usr/share/lemonldap-ng/portal/htdocs/static/common/backgrounds/acme-bg.jpg

# customized pages
ln -s /vagrant/lib/templates/sso/portal $TEMPLATE_DIR/acme

# apply changes
lemonldap-ng-cli -yes 1 set portalSkin 'acme' portalSkinBackground 'acme-bg.jpg'

lemonldap-ng-cli update-cache
systemctl restart lemonldap-ng-fastcgi-server.service
