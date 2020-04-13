# frozen_string_literal: true

Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'ldap' => 'LDAP',
    'sso'  => 'SSO',
    'ubs'  => 'UBS'
  )
end
