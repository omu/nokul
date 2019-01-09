# frozen_string_literal: true

namespace :tenant do
  namespace :units do
    desc 'Print unit trees'
    task :tree do
      hack_argv('raw/yok', 'raw/det', 'src/yok', 'src/all') do |resource|
        Nokul::Tenant::Units.print_tree resource
      end
    end
  end
end
