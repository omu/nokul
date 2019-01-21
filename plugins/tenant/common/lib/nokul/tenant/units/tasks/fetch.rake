# frozen_string_literal: true

namespace :tenant do
  namespace :units do
    desc 'Fetch units'
    task :fetch do
      hack_argv('raw/yok', 'raw/det') do |resource|
        Nokul::Tenant::Units.fetch resource
      end
    end
  end
end
