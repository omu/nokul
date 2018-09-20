# frozen_string_literal: true

task create_high_school_codes: :environment do
  File.open(Rails.root.join('db', 'static_data', 'high_school_codes.yml')) do |high_school_codes|
    high_school_codes.read.each_line do |high_school_code|
      name, code = high_school_code.chomp.split('|')
      HighSchoolType.create(name: name, code: code)
    end
  end
end
