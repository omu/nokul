# frozen_string_literal: true

namespace :import do
  desc 'Import high_school_types from db/static_data'
  task high_school_types: :environment do
    Support.create_entities_from_yaml('HighSchoolType')
  end
end
