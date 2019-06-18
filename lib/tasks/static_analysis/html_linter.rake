# frozen_string_literal: true

namespace :static_analysis do
  desc 'Check HTML files via html_lint'
  task :html_linter do
    sh "yarn exec htmlhint --config .htmlhintrc 'app/views/**/*.html.erb'", verbose: false
  end
end
