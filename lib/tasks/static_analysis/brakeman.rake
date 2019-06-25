# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  require 'brakeman'

  namespace :static_analysis do
    desc 'Scan the project via Brakeman for security vulnerabilities'
    task :brakeman do
      Brakeman.run app_path: '.', print_report: true
    end
  end
end
