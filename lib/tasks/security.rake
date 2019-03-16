# frozen_string_literal: true

namespace :security do
  Rake::TaskManager.record_task_metadata = true

  desc 'Runs brakeman for security vulnerabilities'
  task brakeman: :environment do |task|
    puts "########### #{task.full_comment} ###########"
    sh 'bundle exec brakeman -5 --no-pager --no-summary --no-progress', verbose: false
  end

  desc 'Checks dependencies and vulnerabilities'
  task audit: :environment do |task|
    puts "########### #{task.full_comment} ###########"
    sh 'bundle audit check --update', verbose: false
  end

  desc 'Runs all security tasks'
  task all: %w[brakeman audit]
end
