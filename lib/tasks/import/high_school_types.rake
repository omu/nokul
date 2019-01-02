# frozen_string_literal: true

namespace :import do
  desc 'Imports high_school_types from yaml'
  task high_school_types: :environment do
    Nokul::Support.create_entities_from_yaml('HighSchoolType')
  end
end
