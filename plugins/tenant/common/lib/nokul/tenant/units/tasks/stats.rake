# frozen_string_literal: true

namespace :tenant do
  namespace :units do
    desc 'Unit statistics'
    task stats: :environment do
      hack_argv('raw/yok', 'raw/det') do |resource|
        puts resource
      end
    end
  end
end
