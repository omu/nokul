# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check the documentation format via markdownlint'
  task :markdownlint do
    sh 'markdownlint .github doc plugins README.md', verbose: false
  end
end
