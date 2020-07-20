# frozen_string_literal: true

namespace :tenant do
  namespace :units do
    desc 'Show unit issues'
    task issues: :environment do
      hack_argv('src/yok', 'src/det', 'src/all') do |resource|
        total_number = 0
        Nokul::Tenant::Units.load_source(resource).each do |unit|
          next if unit.issues.blank?

          puts unit
          puts
          Array(unit.issues).each do |issue|
            puts "\t\t#{issue}"
          end
          puts

          total_number += 1
        end

        puts "Toplam sorun sayısı: #{total_number}"
      end
    end
  end
end
