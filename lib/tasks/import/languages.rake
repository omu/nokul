# frozen_string_literal: true

namespace :import do
  desc 'Imports languages from db/static_data'
  task languages: :environment do
    ImportFromYml.parse('Language')
  end
end
