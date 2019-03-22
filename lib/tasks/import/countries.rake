# frozen_string_literal: true

namespace :import do
  desc 'Imports countries from yaml'
  task countries: :environment do
    countries = YAML.load_file(Rails.root.join('db', 'static_data', 'countries.yml'))
    progress_bar = ProgressBar.spawn('Countries', countries.count)

    countries.each do |country|
      existing_country = Country.find_by(name: country['name'])
      if existing_country
        existing_country.update(country)
      else
        Country.create(country)
      end
      progress_bar&.increment
    end
  end
end
