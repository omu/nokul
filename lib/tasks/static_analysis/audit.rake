# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  require 'bundler/audit/task'

  namespace :static_analysis do
    Bundler::Audit::Task.new
  end
end
