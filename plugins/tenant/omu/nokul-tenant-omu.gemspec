# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'nokul/tenant/omu/version'

Gem::Specification.new do |spec|
  spec.name        = 'nokul-tenant-omu'
  spec.version     = Nokul::Tenant::OMU::VERSION
  spec.authors     = ['OMU BAUM Crew']
  spec.email       = ['contact@baum.omu.edu.tr']
  spec.summary     = 'Ondokuz Mayıs University.'
  spec.description = 'Ondokuz Mayıs University tenant for Nokul, a university automation application.'
  spec.license     = 'GPL-3'

  spec.files       = Dir['README.md', 'LICENSE.md', 'CHANGELOG.md', 'Rakefile']
  spec.homepage    = 'https://nokul.omu.sh'
  spec.metadata    = {
    'source_code_uri' => 'https://github.com/omu/nokul/tree/master/plugins/tenant/omu',
    'changelog_uri'   => 'https://github.com/omu/nokul/tree/master/plugins/tenant/omu/CHANGELOG.md'
  }

  spec.required_ruby_version = "~> #{File.read('.ruby-version')}"

  spec.add_dependency 'nokul-tenant'
  spec.add_dependency 'rails'
end
