# frozen_string_literal: true

namespace :database do
  Rake::TaskManager.record_task_metadata = true

  desc 'Scans missing or unnecessary database indexes'
  task :index do |task|
    puts "########### #{task.full_comment} ###########"
    Rake::Task['db:find_indexes'].invoke
  end

  desc 'Runs all database tasks'
  task all: %w[index]
end
