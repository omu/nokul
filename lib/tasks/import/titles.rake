# frozen_string_literal: true

namespace :import do
  desc 'Import titles from db/static_data'
  task titles: :environment do
    Nokul::Support.create_entities_from_yaml('Title')
  end
end
