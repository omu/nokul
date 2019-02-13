require 'rubygems'
require 'net/ldap'

ldap = Net::LDAP.new host: '127.0.0.1',
                     port: 389,
                     auth: {
                       method: :simple,
                       username: 'cn=admin,dc=test,dc=omu,dc=edu,dc=tr',
                       password: '12345'
                     }

filter = Net::LDAP::Filter.eq('uid', '09060286')
treebase = 'dc=test,dc=omu,dc=edu,dc=tr'

ldap.search(base: treebase, filter: filter) do |entry|
  puts entry
  puts "DN: #{entry.dn}"
  entry.each do |attribute, values|
    puts "   #{attribute}:"
    values.each do |value|
      puts "      --->#{value}"
    end
  end
end

p '-------SEARCH-----------'
p ldap.get_operation_result
p '-----------------------'

# dn = 'uid=13210271, ou=People, dc=omu, dc=edu, dc=tr'
# attr = {
#   cn: 'Emre Can Yılmaz',
#   objectclass: %w[posixAccount inetOrgPerson shadowAccount],
#   uid: 'ecylmz',
#   sn: 'Yılmaz',
#   givenName: 'Emre Can',
#   displayName: 'Emre Can Yılmaz',
#   uidNumber: '10100',
#   gidNumber: '5500',
#   userPassword: 'ecylmzldap',
#   gecos: 'Emre Can Yilmaz',
#   loginShell: '/bin/bash',
#   homeDirectory: '/home/ecylmz',
#   mail: 'emrecan@ecylmz.com'
# }
#
# ldap.add(dn: dn, attributes: attr)
# p '---------ADD-----------'
# p ldap.get_operation_result
# p '-----------------------'

filter = Net::LDAP::Filter.eq('cn', 'Mustafa*')
ldap.search(base: treebase, filter: filter) do |entry|
  puts entry
  puts "DN: #{entry.dn}"
  entry.each do |attribute, values|
    puts "   #{attribute}:"
    values.each do |value|
      puts "      --->#{value}"
    end
  end
end

p '-------SEARCH----------'
p ldap.get_operation_result
p '-----------------------'

# ldap.replace_attribute(dn, :mail, 'new_mail@ecylmz.com')
# p '----REPLACE ATTRIBUTE---'
# p ldap.get_operation_result
# p '-----------------------'

# ldap.delete_attribute(dn, :mail)
# p '----DELETE ATTRIBUTE---'
# p ldap.get_operation_result
# p '-----------------------'

# ldap.delete dn: dn
# p '--------DELETE---------'
# p ldap.get_operation_result
# p '-----------------------'
