# frozen_string_literal: true

namespace :security do
  # Following paths emits parse errors due to the brakeman's Ruby parser
  # See https://github.com/presidentbeef/brakeman/issues/1173
  # TODO: Try to remove this workaround when brakeman comes with a new parser
  BRAKEMAN_SKIP_FILES = %w[
    lib/support/ruling/checker.rb
    lib/support/tenant/unit/rules.rb
  ].freeze

  desc 'Runs brakeman for vulnerabilities'
  task :brakeman do
    sh "bundle exec brakeman -q --skip-files #{BRAKEMAN_SKIP_FILES.join(',')}"
  end

  desc 'Checks dependencies and vulnerabilities'
  task :audit do
    sh 'bundle audit check --update'
  end

  desc 'Runs all security tasks'
  task all: %w[brakeman audit]
end
