# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check ERB templates via erb_linter'
  task erb_linter: :environment do
    sh 'bundle exec erblint --autocorrect app/views', verbose: false
  end
end
