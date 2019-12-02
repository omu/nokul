# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check broken links in documents via liche'
  task liche: :environment do
    sh 'liche -d . -r .github doc plugins README.md', verbose: false
  end
end
