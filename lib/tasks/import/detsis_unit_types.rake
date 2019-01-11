# frozen_string_literal: true

namespace :import do
  desc 'Imports administrative_units from db/static_data'
  task detsis_unit_types: :environment do
    administrative_unit_types = Tenant::Units::Raw::DETMany::TYPES.keys
    progress_bar = ProgressBar.spawn('Administrative Unit Types', administrative_unit_types.count)

    i = 900 # 0-900 kept for YOKSIS types
    administrative_unit_types.each do |type|
      UnitType.create(name: type, code: i)
      i += 1
      progress_bar&.increment
    end
  end
end
