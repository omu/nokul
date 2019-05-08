# frozen_string_literal: true

namespace :import do
  desc 'Imports units from tenant unit data'
  task units: :environment do
    units = Tenant.units
    progress_bar = ProgressBar.spawn('Units', units.count)

    units.each do |unit|
      default_district = District.find_by(name: Tenant.configuration.contact.district)
      parent_unit = if unit.parent_yoksis_id
                      Unit.find_by(yoksis_id: unit.parent_yoksis_id)
                    elsif unit.parent_detsis_id
                      Unit.find_by(detsis_id: unit.parent_detsis_id)
                    end

      params = {
        abbreviation: unit.abbreviation,
        code: unit.code,
        founded_at: unit.founded_at,
        name: unit.name,
        yoksis_id: unit.yoksis_id,
        detsis_id: unit.detsis_id,
        osym_id: unit.osym,
        foet_code: unit.foet_code,
        duration: unit.duration,
        district: District.find_by(name: unit.district_id) || default_district,
        parent: parent_unit || nil,
        unit_instruction_language_id: UnitInstructionLanguage.find_by(name: unit.unit_instruction_language_id).try(:id),
        unit_instruction_type_id: UnitInstructionType.find_by(name: unit.unit_instruction_type_id).try(:id),
        unit_status_id: UnitStatus.find_by(name: unit.unit_status_id).try(:id),
        unit_type_id: UnitType.find_by(name: unit.unit_type_id).try(:id)
      }
      Unit.create(params)
      progress_bar&.increment
    end
  end
end
