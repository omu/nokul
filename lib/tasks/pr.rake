# frozen_string_literal: true

desc 'Runs all necessary checks before a pull request'
task :pr do
  Rake::Task['quality:rails'].invoke
  Rake::Task['security:all'].invoke
  sh 'bundle exec rake test'
end
