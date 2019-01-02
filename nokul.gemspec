# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'nokul/version'

Gem::Specification.new do |spec|
  spec.name        = 'nokul'
  spec.version     = Nokul::VERSION
  spec.authors     = ['OMU BAUM Crew']
  spec.email       = ['contact@baum.omu.edu.tr']
  spec.summary     = 'Nokul stands for "Nitelikli Okul".'
  spec.description = 'Nokul is a web application for university automation.'
  spec.license     = 'GPL-3'

  spec.files       = Dir['README.md', 'LICENSE.md', 'CHANGELOG.md', 'Rakefile']
  spec.homepage    = 'https://nokul.omu.sh'
  spec.metadata    = {
    'source_code_uri' => 'https://github.com/omu/nokul/tree/master',
    'changelog_uri' => 'https://github.com/omu/nokul/tree/master/CHANGELOG.md'
  }

  spec.add_dependency 'nokul-support'
  spec.add_dependency 'nokul-tenant'
end
