# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check JavaScript files via eslint'
  task eslint: :environment do
    sh 'yarn run lint', verbose: false
  end
end
