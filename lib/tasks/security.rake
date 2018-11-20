# frozen_string_literal: true

namespace :security do
  Rake::TaskManager.record_task_metadata = true

  # Following paths emits parse errors due to the brakeman's Ruby parser
  # See https://github.com/presidentbeef/brakeman/issues/1173
  # TODO: Try to remove this workaround when brakeman comes with a new parser
  FILES_TO_SKIP = %w[
    lib/support/ruling/checker.rb
    lib/support/tenant/unit/rules.rb
  ].freeze

  desc 'Runs brakeman for security vulnerabilities'
  task :brakeman do |task|
    puts "########### #{task.full_comment} ###########"
    sh "bundle exec brakeman -5 --no-summary --no-progress --skip-files #{FILES_TO_SKIP.join(',')}", verbose: false
  end

  desc 'Checks dependencies and vulnerabilities'
  task :audit do |task|
    puts "########### #{task.full_comment} ###########"
    sh 'bundle audit check --update', verbose: false
  end

  desc 'Runs all security tasks'
  task all: %w[brakeman audit]
end
