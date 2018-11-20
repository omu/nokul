# frozen_string_literal: true

namespace :test do
  Rake::TaskManager.record_task_metadata = true

  desc 'Runs the whole test suite'
  task :all do |task|
    puts "########### #{task.full_comment} ###########"
    sh 'bundle exec rake test', verbose: false
  end
end
