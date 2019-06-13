# frozen_string_literal: true

desc 'Runs all necessary checks before a pull request'
task pr: %w[prerequisities:all static_analysis:all db:all] do
  sh 'bundle exec rails test:system test'
end
