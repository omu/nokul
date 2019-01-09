# frozen_string_literal: true

desc 'Runs all necessary checks before a pull request'
task :pull_request do
  Rake::Task['quality:all'].invoke
  Rake::Task['security:all'].invoke
  Rake::Task['database:all'].invoke
  sh 'bundle exec rails test:system test'
end
