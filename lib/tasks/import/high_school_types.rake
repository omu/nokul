# frozen_string_literal: true

namespace :import do
  desc 'Imports high_school_types from yaml'
  task high_school_types: :environment do
    Support.create_entities_from_yaml('HighSchoolType')
  end
end
