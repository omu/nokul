# frozen_string_literal: true

require 'bundler/audit/task'

namespace :static_analysis do
  Bundler::Audit::Task.new
end
