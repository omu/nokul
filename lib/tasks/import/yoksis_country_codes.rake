# frozen_string_literal: true

namespace :import do
  desc 'Adds YOKSIS codes to countries from db/static_data'
  task yoksis_country_codes: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'yoksis_countries.yml'))
    progress_bar = ProgressBar.spawn('YOKSIS Country Codes', file.count)

    file.each do |yoksis_country|
      country = Country.find_by(name: yoksis_country['name'])
      country&.update(yoksis_code: yoksis_country['yoksis_code'])
      progress_bar.increment
    end
  end
end
