# frozen_string_literal: true

namespace :db do
  desc 'Scans missing or unnecessary database indexes'
  task index: %w[db:find_indexes]
end
