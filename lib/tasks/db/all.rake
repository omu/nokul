# frozen_string_literal: true

namespace :db do
  desc 'Run all the custom db tasks'
  task all: %w[dump:sample_data dump:static_data index]
end
