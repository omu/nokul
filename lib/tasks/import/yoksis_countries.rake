# frozen_string_literal: true

namespace :import do
  desc 'Add YOKSIS codes to countries from db/static_data'
  task yoksis_countries: :environment do
    countries = YAML.load_file(Rails.root.join('db/static_data/yoksis_countries.yml'))

    progress_bar = ProgressBar.spawn('YOKSIS - Country Codes', countries.count)

    countries.each do |country|
      found = Country.find_by(name: country['name'])
      found&.update(yoksis_code: country['yoksis_code'])

      progress_bar&.increment
    end
  end
end
