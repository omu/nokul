# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

# Auto-load the whole application for rake tasks. Slow, but no problem for rake tasks.
Rails.application.reloader.to_prepare do
  Dir[
    Rails.root.join('app', '**', '**', '*.rb'),
  ].each { |file| require_dependency file }
end

Rails.application.load_tasks
