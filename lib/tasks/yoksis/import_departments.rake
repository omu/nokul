# frozen_string_literal: true

namespace :yoksis do
  task import_departments: :environment do
    file = File.open(Rails.root.join('db', 'static_data', 'units.yml'))
  rescue Errno::ENOENT => e
    puts "File/path not found! #{e}"
  else
    # YOKSIS export doesn't provide unit locations, so the default district set to Atakum for this case
    district = District.find_by(name: 'Atakum')
    puts 'It works silently if all OK, otherwise you will receive errors.'

    file.read.each_line do |unit|
      yoksis_id, name, unit_type, parent_yoksis_id, status, language, instruction_type, founded_at, duration,
      foet_code = unit.split('|').map(&:strip)

      statuses = {
        'Pasif' => UnitStatus.find_by(code: 0),
        'Aktif' => UnitStatus.find_by(code: 1),
        'Yarı Pasif' => UnitStatus.find_by(code: 2),
        'Kapalı' => UnitStatus.find_by(code: 3),
        'Arşiv' => UnitStatus.find_by(code: 4)
      }

      instruction_types = {
        'NORMAL ÖĞRETİM' => UnitInstructionType.find_by(code: 1),
        'İKİNCİ ÖĞRETİM' => UnitInstructionType.find_by(code: 2),
        'UZAKTAN ÖĞRETİM' => UnitInstructionType.find_by(code: 3),
        'AÇIK ÖĞRETİM' => UnitInstructionType.find_by(code: 4)
      }

      # matching hash for English-Turkish unit names.
      unit_types = {}
      Unit.types.each do |unit_en|
        tr = I18n.t("units.#{unit_en.underscore}", locale: :tr)
        unit_types[tr] = unit_en
      end

      case unit_type
      when *unit_types.keys
        unit = Unit.new(
          name: name.strip,
          yoksis_id: yoksis_id,
          founded_at: founded_at ? founded_at.to_date : nil,
          foet_code: foet_code,
          duration: duration.to_i,
          type: unit_types[unit_type.to_s],
          parent: Unit.find_by(yoksis_id: parent_yoksis_id),
          district: district,
          unit_instruction_type: instruction_types[instruction_type.to_s],
          unit_instruction_language: UnitInstructionLanguage.find_by(name: language),
          unit_status: statuses[status.to_s]
        )
        puts "FAIL: #{unit.id} - #{unit.name} can not be created!" unless unit.save!
      else
        puts "We have no idea about this unit: #{unit}. Check your locales for missing translations for the unit."
      end
    end
  ensure
    file.close
  end
end
