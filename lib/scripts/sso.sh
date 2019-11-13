#!/bin/bash

set -euo pipefail; [[ -z ${TRACE:-}  ]] || set -x

export DEBIAN_FRONTEND=noninteractive

if [[ ! -f /etc/apt/sources.list.d/lemonldap-ng.list ]]; then
	cat >/etc/apt/sources.list.d/lemonldap-ng.list <<-EOF
		deb     https://lemonldap-ng.org/deb 2.0 main
	EOF
	curl -fsSL https://lemonldap-ng.org/_media/rpm-gpg-key-ow2 | apt-key add -

	apt-get -y update
fi

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
sed -i -e 's/^;checkTime.*/checkTime = 1/' /etc/lemonldap-ng/lemonldap-ng.ini
sed -i -e "s/^logLevel.*/logLevel=debug/" /etc/lemonldap-ng/lemonldap-ng.ini

# allow sso vagrant ip for reload
sed -i -e "35i \ \ \ \ allow 10.0.3.19;" /etc/nginx/sites-available/handler-nginx.conf

# for vagrant
ln -s /vagrant/sso/etc/nginx/dhparam.pem /etc/nginx/dhparam.pem
ln -s /vagrant/sso/etc/nginx/snippets/self-signed.conf /etc/nginx/snippets/self-signed.conf
ln -s /vagrant/sso/etc/nginx/snippets/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
ln -s /vagrant/sso/etc/nginx/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
ln -s /vagrant/sso/etc/nginx/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
ln -s /vagrant/sso/etc/nginx/portal-nginx.conf /etc/nginx/sites-enabled/

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
lemonldap-ng-cli -yes 1 set cspFormAction *

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
	ldapBase 'dc=vagrant,dc=ga' \
	managerDn 'cn=admin,dc=vagrant,dc=ga' \
	managerPassword '12345' \
	AuthLDAPFilter 'objectClass=kopano-user' \
	mailLDAPFilter '(&(mail=$mail)(objectClass=kopano-user))'

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
	'locationRules/manager.sso.vagrant.ga' 'default' '$uid eq "john"' \
	'locationRules/manager.sso.vagrant.ga' '(?#Sessions)/(.*?\.(fcgi|psgi)/)?sessions' '$uid eq "john"' \
	'locationRules/manager.sso.vagrant.ga' '(?#Configuration)^/(.*?\.(fcgi|psgi)/)?(manager\.html|confs/|$)' '$uid eq "john"' \
	'locationRules/manager.sso.vagrant.ga' '(?#Notifications)/(.*?\.(fcgi|psgi)/)?notifications' '$uid eq "john"'

# SAML configuration
lemonldap-ng-cli -yes 1 set \
	issuerDBSAMLActivation 1 \
	samlServicePrivateKeySig "`cat /vagrant/sso/etc/lemonldap-priv-key.pem`" \
	samlServicePublicKeySig "`cat /vagrant/sso/etc/lemonldap-pub-key.pem`"

# SAML Organization configuration
lemonldap-ng-cli -yes 1 set \
	samlOrganizationName 'OMU BAUM' \
	samlOrganizationDisplayName 'OMU BAUM' \
	samlOrganizationURL 'https://baum.omu.edu.tr'

# Hokul SAML SP configuration
lemonldap-ng-cli -yes 1 addKey \
	samlSPMetaDataXML/hokul samlSPMetaDataXML "`cat /vagrant/sso/etc/hokul-sp-metadata.xml`"

lemonldap-ng-cli -yes 1 addKey \
	samlSPMetaDataExportedAttributes/hokul mail '1;mail' \
	samlSPMetaDataExportedAttributes/hokul cn '1;cn' \
	samlSPMetaDataExportedAttributes/hokul sn '1;sn' \
	samlSPMetaDataExportedAttributes/hokul mobile '1;mobile' \
	samlSPMetaDataExportedAttributes/hokul givenName '1;givenName'

# SOGo SAML SP configuration
lemonldap-ng-cli -yes 1 addKey \
	samlSPMetaDataXML/sogo samlSPMetaDataXML "`cat /vagrant/sso/etc/sogo-sp-metadata.xml`"

lemonldap-ng-cli -yes 1 addKey \
	samlSPMetaDataExportedAttributes/sogo cn '1;cn' \
	samlSPMetaDataExportedAttributes/sogo mail '1;mail' \
	samlSPMetaDataExportedAttributes/sogo uid '1;uid' \

# OIDC configuration
lemonldap-ng-cli -yes 1 set \
	issuerDBOpenIDConnectActivation 1 \
	oidcServiceMetaDataIssuer 'https://auth.sso.vagrant.ga' \
	oidcServicePrivateKeySig "`cat /vagrant/sso/etc/oidc.key`" \
	oidcServicePublicKeySig "`cat /vagrant/sso/etc/oidc_pub.key`" \
	oidcServiceKeyIdSig "`genpasswd`" \
	oidcServiceAllowHybridFlow 1 \
	oidcServiceAllowAuthorizationCodeFlow 1 \
	oidcServiceAllowImplicitFlow 1

# OIDC RP configuration
# Hokul
lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataExportedVars/hokul email mail \
        oidcRPMetaDataExportedVars/hokul family_name sn \
        oidcRPMetaDataExportedVars/hokul name cn \
        oidcRPMetaDataExportedVars/hokul sub uid

lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataOptions/hokul oidcRPMetaDataOptionsClientID testclientid \
        oidcRPMetaDataOptions/hokul oidcRPMetaDataOptionsClientSecret testclientsecret

lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataOptions/hokul oidcRPMetaDataOptionsRedirectUris 'http://other.vagrant.ga:3000/callback' \
        oidcRPMetaDataOptions/hokul oidcRPMetaDataOptionsPostLogoutRedirectUris 'http://other.vagrant.ga:3000'
# Konnect
lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataExportedVars/konnect email mail \
        oidcRPMetaDataExportedVars/konnect family_name sn \
        oidcRPMetaDataExportedVars/konnect name cn \
        oidcRPMetaDataExportedVars/konnect sub uid

lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataOptions/konnect oidcRPMetaDataOptionsClientID konnect \
        oidcRPMetaDataOptions/konnect oidcRPMetaDataOptionsClientSecret konnect

lemonldap-ng-cli -yes 1 addKey \
        oidcRPMetaDataOptions/konnect oidcRPMetaDataOptionsPostLogoutRedirectUris 'https://mail.sso.vagrant.ga'


lemonldap-ng-cli update-cache
reboot
