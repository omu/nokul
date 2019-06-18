# frozen_string_literal: true

namespace :import do
  desc 'Import countries from db/static_data'
  task countries: :environment do
    countries = YAML.load_file(Rails.root.join('db', 'static_data', 'countries.yml'))

    progress_bar = ProgressBar.spawn('YOKSIS - Countries', countries.count)

    countries.each do |country|
      found = Country.find_by(name: country['name'])
      found ? found.update(country) : Country.create(country)

      progress_bar&.increment
    end
  end
end
