# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'nokul/support/version'

Gem::Specification.new do |spec|
  spec.name        = 'nokul-support'
  spec.version     = Nokul::Support::VERSION
  spec.authors     = ['OMU BAUM Crew']
  spec.email       = ['contact@baum.omu.edu.tr']
  spec.summary     = 'ActiveSupport like toolkit of support libraries.'
  spec.description = 'ActiveSupport like generic support libraries for Nokul ecosystem.'
  spec.license     = 'GPL-3'

  spec.files       = Dir['README.md', 'LICENSE.md', 'CHANGELOG.md', 'Rakefile']
  spec.homepage    = 'https://nokul.omu.sh'
  spec.metadata    = {
    'source_code_uri' => 'https://github.com/omu/nokul/tree/master/plugins/tenant/support',
    'changelog_uri'   => 'https://github.com/omu/nokul/tree/master/plugins/tenant/support/CHANGELOG.md'
  }

  spec.required_ruby_version = "~> #{File.read('.ruby-version')}"

  spec.add_dependency 'activesupport', '>= 6.0.3.1'
end
