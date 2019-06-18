# frozen_string_literal: true

namespace :static_analysis do
  desc 'Run all static analysis tasks'
  task all: %w[bundle:audit brakeman erb_linter executables html_linter markdownlint rubocop secrets]
end
