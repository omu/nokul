# frozen_string_literal: true

namespace :import do
  desc 'Imports languages from yaml'
  task languages: :environment do
    Nokul::Support.create_entities_from_yaml('Language')
  end
end
