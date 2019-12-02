# frozen_string_literal: true

namespace :import do
  desc 'Import cities from db/static_data'
  task cities: :environment do
    cities = YAML.load_file(Rails.root.join('db/static_data/cities.yml'))

    progress_bar = ProgressBar.spawn('YOKSIS - Cities', cities.count)

    cities.each do |city|
      country = Country.find_by(alpha_2_code: city['alpha_2_code'].split('-').first)

      found = City.find_by(name: city['name'])
      found ? found.update(city) : country.cities.create(city)

      progress_bar&.increment
    end
  end
end
