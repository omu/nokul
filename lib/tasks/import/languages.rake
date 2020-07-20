# frozen_string_literal: true

namespace :import do
  desc 'Import languages from db/static_data'
  task languages: :environment do
    Nokul::Support.create_entities_from_yaml('Language')
  end
end
