# frozen_string_literal: true

namespace :yoksis do
  desc 'import country codes from YOKSIS'
  task import_yoksis_country_codes: :environment do
    file = File.open(Rails.root.join('db', 'static_data', 'yoksis_countries.yml'))
  rescue Errno::ENOENT => e
    puts "File/path not found! #{e}"
  else
    puts 'Importing country codes from CSV.'
    file.read.each_line do |yoksis_country|
      yoksis_code, name = yoksis_country.split('|').map(&:strip)

      country = Country.find_by(name: name)
      next if country.blank?

      country.yoksis_code = yoksis_code.to_i
      puts "FAIL: #{country.yoksis_code} - #{country.name} can not be updated!" unless country.save!
    end
  ensure
    file.close
  end
end
