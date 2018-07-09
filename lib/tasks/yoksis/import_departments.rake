# frozen_string_literal: true

namespace :yoksis do
  task import_departments: :environment do
    file = File.open(Rails.root.join('db', 'static_data', 'units.yml'))
  rescue Errno::ENOENT => e
    puts "File/path not found! #{e}"
  else
    puts 'Importing departments from CSV.'

    # YOKSIS export doesn't provide unit locations, so the default district set to Atakum for this case
    district = District.find_by(name: 'Atakum')

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

      unit = Unit.new(
        name: name.strip,
        yoksis_id: yoksis_id,
        founded_at: founded_at ? founded_at.to_date : nil,
        foet_code: foet_code,
        duration: duration.to_i,
        parent: Unit.find_by(yoksis_id: parent_yoksis_id),
        district: district,
        unit_type: UnitType.find_by(name: unit_type),
        unit_instruction_type: instruction_types[instruction_type.to_s],
        unit_instruction_language: UnitInstructionLanguage.find_by(name: language),
        unit_status: statuses[status.to_s]
      )

      puts "FAIL: #{unit.id} - #{unit.name} can not be created!" unless unit.save!
    end
  ensure
    file.close
  end
end
