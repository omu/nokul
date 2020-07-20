# frozen_string_literal: true

namespace :import do
  desc 'Import administrative units from db/static_data'
  task detsis_unit_types: :environment do
    progress_bar = ProgressBar.spawn('DETSIS - Administrative Unit Types', Nokul::Tenant.unit_types.count)

    Nokul::Tenant.unit_types.each_with_index do |unit_type, index|
      # 0-900 is reserved for YOKSIS unit types.
      UnitType.create(name: unit_type, code: index + 900)

      progress_bar&.increment
    end
  end
end
