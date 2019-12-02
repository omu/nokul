# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check the documentation format via markdownlint'
  task markdownlint: :environment do
    sh 'yarn run markdownlint doc README.md', verbose: false
  end
end
