# frozen_string_literal: true

namespace :import do
  desc 'Imports countries from db/static_data'
  task countries: :environment do
    ImportFromYml.parse('Country')
  end
end
