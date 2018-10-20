# frozen_string_literal: true

namespace :import do
  desc 'Imports administrative_units from db/static_data'
  task administrative_units: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'administrative_units.yml'))
    progress_bar = ProgressBar.spawn('Administrative Units', file.count)

    file.each do |unit|
      parent =
        if unit['parent_yoksis_id']
          Unit.find_by(yoksis_id: unit['parent_yoksis_id'])
        else
          Unit.find_by(detsis_id: unit['parent_detsis_id'])
        end
      existing_unit = Unit.find_by(detsis_id: unit['detsis_id'])

      unit['district_id'] = District.find_by(name: unit['district_id']).id
      unit['parent'] = parent
      unit['unit_status_id'] = UnitStatus.find_by(name: 'Aktif').id
      unit_params = unit.except('parent_yoksis_id', 'parent_detsis_id')

      existing_unit.present? ? existing_unit.update(unit_params) : Unit.create(unit_params)
      progress_bar&.increment
    end
  end
end
