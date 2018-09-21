# frozen_string_literal: true

namespace :import do
  desc 'Imports high_school_types from db/static_data'
  task high_school_types: :environment do
    ImportFromYml.parse('HighSchoolType')
  end
end
