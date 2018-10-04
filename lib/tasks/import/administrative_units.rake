# frozen_string_literal: true

namespace :import do
  desc 'Imports administrative_units from db/static_data'
  task administrative_units: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'administrative_units.yml'))
    progress_bar = ProgressBar.spawn('Administrative Units', file.count)

    file.each do |unit|
      unit['district_id'] = District.find_by(
        name: unit['district_id']
      ).id
      unit['parent'] = Unit.find_by(
        yoksis_id: unit['parent_yoksis_id']
      )
      unit['unit_status_id'] = UnitStatus.find_by(
        name: 'Aktif'
      ).id
      Unit.create(unit.except('parent_yoksis_id'))
      progress_bar&.increment
    end
  end
end
