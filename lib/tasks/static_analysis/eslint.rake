# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check JavaScript files via eslint'
  task :eslint do
    sh 'yarn run lint', verbose: false
  end
end
