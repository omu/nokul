# frozen_string_literal: true

namespace :import do
  desc 'Imports units from db/static_data'
  task units: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'units.yml'))
    progress_bar = ProgressBar.spawn('Units', file.count)

    file.each do |unit|
      unit['unit_status_id'] = UnitStatus.find_by(
        name: unit['unit_status_id']
      ).id
      unit['unit_instruction_language_id'] = UnitInstructionLanguage.find_by(
        name: unit['unit_instruction_language_id']
      ).id
      unit['unit_instruction_type_id'] = UnitInstructionType.find_by(
        name: unit['unit_instruction_type_id']
      ).id
      unit['unit_type_id'] = UnitType.find_by(
        name: unit['unit_type_id']
      ).id
      unit['parent'] = Unit.find_by(
        yoksis_id: unit['parent_yoksis_id']
      )
      unit['district_id'] = District.find_by(
        name: Rails.application.config.tenant.contact.main_district
      ).id
      Unit.create(unit.except('parent_yoksis_id'))
      progress_bar&.increment
    end
  end
end
