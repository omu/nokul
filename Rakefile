# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.reloader.to_prepare do
  Dir[
    Rails.root.join('app', 'services', '**', '*.rb'),
  ].each { |file| require_dependency file }
end

Rails.application.load_tasks
