# frozen_string_literal: true

namespace :import do
  desc 'Imports administrative_units from db/static_data'
  task detsis_unit_types: :environment do
    unit_types = Tenant.unit_types
    progress_bar = ProgressBar.spawn('Administrative Unit Types', unit_types.count)

    i = 900 # 0-900 reserved for YOKSIS types
    unit_types.each do |unit_type|
      UnitType.create(name: unit_type, code: i)
      i += 1
      progress_bar&.increment
    end
  end
end
