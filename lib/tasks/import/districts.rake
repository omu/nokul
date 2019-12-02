# frozen_string_literal: true

namespace :import do
  desc 'Import districts from db/static_data'
  task districts: :environment do
    districts = YAML.load_file(Rails.root.join('db/static_data/districts.yml'))

    progress_bar = ProgressBar.spawn('YOKSIS - Districts', districts.count)

    districts.each do |district|
      city = City.find_by(alpha_2_code: district['alpha_2_code'])
      city.districts.create(district.except('alpha_2_code'))

      progress_bar&.increment
    end
  end
end
