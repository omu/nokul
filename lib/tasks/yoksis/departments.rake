namespace :yoksis do
  task :departments => :environment do
    begin
      file = File.open(Rails.root.join('db', 'units.yml'))
    rescue Errno::ENOENT => e
      puts "File/path not found! #{e}"
    else
      city = City.find_by(iso: 'TR-55') # default city set to Samsun for this case
      puts 'It works silently if all OK, otherwise you will receive errors.'

      file.read.each_line do |unit|
        yoksis_id, name, unit_type, parent_yoksis_id, status, language, instruction_type, founded_at, duration,
        foet_code = unit.split('|').map(&:strip)

        statuses = {
          'Pasif' => Unit.statuses['passive'],
          'Aktif' => Unit.statuses['active'],
          'Yarı Pasif' => Unit.statuses['partially_passive'],
          'Kapalı' => Unit.statuses['closed'],
          'Arşiv' => Unit.statuses['archived']
        }

        instruction_types = {
          'NORMAL ÖĞRETİM' => Unit.instruction_types['formal'],
          'İKİNCİ ÖĞRETİM' => Unit.instruction_types['evening'],
          'UZAKTAN ÖĞRETİM' => Unit.instruction_types['distance_education'],
          'AÇIK ÖĞRETİM' => Unit.instruction_types['open_education']
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
            status: statuses[status.to_s],
            founded_at: founded_at ? founded_at.to_date : nil,
            instruction_type: instruction_types[instruction_type.to_s],
            foet_code: foet_code,
            type: unit_types[unit_type.to_s],
            parent: Unit.find_by(yoksis_id: parent_yoksis_id),
            city: city
          )
          puts "FAIL: #{unit.id} - #{unit.name} can not be created!" unless unit.save!
        else
          puts "We have no idea about this unit: #{unit}. Check your locales for missing translations for the unit."
        end
      end
    end
  end
end
