# frozen_string_literal: true

namespace :import do
  desc 'Imports cities from db/static_data'
  task cities: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'cities.yml'))
    progress_bar = ProgressBar.spawn('Cities', file.count)

    file.each do |city|
      country = Country.find_by(alpha_2_code: city['alpha_2_code'].split('-').first)
      country.cities.create(city)
      progress_bar.increment
    end
  end
end
