# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'nokul/tenant/acme/version'

Gem::Specification.new do |spec|
  spec.name        = 'nokul-tenant-acme'
  spec.version     = Nokul::Tenant::ACME::VERSION
  spec.authors     = ['OMU BAUM Crew']
  spec.email       = ['contact@baum.omu.edu.tr']
  spec.summary     = 'Ondokuz Mayıs University.'
  spec.description = 'Ondokuz Mayıs University tenant for Nokul, a university automation application.'
  spec.license     = 'GPL-3'

  spec.files       = Dir['README.md', 'LICENSE.md', 'CHANGELOG.md', 'Rakefile']
  spec.homepage    = 'https://nokul.omu.sh'
  spec.metadata    = {
    'source_code_uri' => 'https://github.com/omu/nokul/tree/master/plugins/tenant/acme',
    'changelog_uri' => 'https://github.com/omu/nokul/tree/master/plugins/tenant/acme/CHANGELOG.md'
  }

  spec.add_dependency 'nokul-tenant'
  spec.add_dependency 'rails', '~> 6.0.0'
end
