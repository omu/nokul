# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  require 'rubocop/rake_task'

  namespace :static_analysis do
    desc 'Check code quality via RuboCop'
    RuboCop::RakeTask.new do |task|
      task.requires << 'rubocop-minitest'
      task.requires << 'rubocop-performance'
      task.requires << 'rubocop-rails'
      task.options = %w[-f fu -D]
    end
  end
end
