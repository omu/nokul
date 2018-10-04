# frozen_string_literal: true

namespace :import do
  desc 'Imports districts from db/static_data'
  task districts: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'districts.yml'))
    progress_bar = ProgressBar.spawn('Districts', file.count)

    file.each do |district|
      city = City.find_by(alpha_2_code: district['alpha_2_code'])
      city.districts.create(district.except('alpha_2_code'))
      progress_bar&.increment
    end
  end
end
