# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'nokul/tenant/version'

Gem::Specification.new do |spec|
  spec.name        = 'nokul-tenant'
  spec.version     = Nokul::Tenant::VERSION
  spec.authors     = ['OMU BAUM Crew']
  spec.email       = ['contact@baum.omu.edu.tr']
  spec.summary     = 'Common logic for all Nokul tenants.'
  spec.description = 'This Gem provides the common logic for all tenants of Nokul, a university automation application.'
  spec.license     = 'GPL-3'

  spec.files       = Dir['README.md', 'LICENSE.md', 'CHANGELOG.md', 'Rakefile']
  spec.homepage    = 'https://nokul.omu.sh'
  spec.metadata    = {
    'source_code_uri' => 'https://github.com/omu/nokul/tree/master/plugins/tenant/common',
    'changelog_uri'   => 'https://github.com/omu/nokul/tree/master/plugins/tenant/common/CHANGELOG.md'
  }

  spec.add_dependency 'nokul-support'
end
