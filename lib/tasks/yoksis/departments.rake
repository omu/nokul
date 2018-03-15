namespace :yoksis do
  task :departments do
    begin
      File.open(Rails.root.join('db', 'units.yml')) do |units|
        units.read.each_line do |unit|
          yoksis_id, name, unit_type, parent_yoksis_id, status, language, instruction_type, founded_at, duration,
          foet_code = unit.split('|').map(&:strip)

          statuses = {
            'Pasif' => 0,
            'Aktif' => 1,
            'Yarı Pasif' => 2,
            'Kapalı' => 3,
            'Arşiv' => 4
          }

          unit_types = {
            'Üniversite' => 'University',
            'Fakülte' => 'Faculty',
            'Yüksekokul' => 'Academy',
            'Meslek Yüksekokulu' => 'VocationalSchool',
            'Enstitü' => 'Institute',
            'Bölüm' => 'Department',
            'Anabilim Dalı' => 'ScienceDiscipline',
            'Anasanat Dalı' => 'ArtDiscipline',
            'Disiplinlerarası Anabilim Dalı' => 'InterdisciplinaryDiscipline',
            'Önlisans/Lisans Programı' => 'UndergraduateProgram',
            'Yüksek Lisans Programı' => 'MasterProgram',
            'Doktora Programı' => 'DoctoralProgram',
            'Disiplinlerarası Yüksek Lisans Programı' => 'InterdisciplinaryMasterProgram',
            'Disiplinlerarası Doktora Programı' => 'InterdisciplinaryDoctoralProgram',
            'Rektörlük' => 'Rectorship',
            'Araştırma ve Uygulama Merkezi' => 'ResearchCenter',
            'Sanatta Yeterlilik Programı' => 'ProficiencyInArtProgram',
            'Bilim Dalı' => 'Discipline'
          }

          instruction_types = {
            'NORMAL ÖĞRETİM' => 1,
            'İKİNCİ ÖĞRETİM' => 2,
            'UZAKTAN ÖĞRETİM' => 3,
            'AÇIK ÖĞRETİM' => 4
          }

          units = [
            'Üniversite', 'Fakülte', 'Yüksekokul', 'Meslek Yüksekokulu', 'Enstitü', 'Rektörlük',
            'Araştırma ve Uygulama Merkezi', 'Anabilim Dalı', 'Anasanat Dalı', 'Bölüm',
            'Disiplinlerarası Anabilim Dalı', 'Bilim Dalı'
          ]

          programs = [
            'Önlisans/Lisans Programı', 'Yüksek Lisans Programı', 'Doktora Programı',
            'Disiplinlerarası Yüksek Lisans Programı', 'Disiplinlerarası Doktora Programı',
            'Sanatta Yeterlilik Programı'
          ]

          case unit_type
          when *units
            unit = Unit.new(
              name: name.strip,
              yoksis_id: yoksis_id,
              status: statuses[status.to_s].to_i,
              founded_at: founded_at ? founded_at.to_date : nil,
              instruction_type: instruction_types[instruction_type.to_s],
              foet_code: foet_code,
              type: unit_types[unit_type.to_s],
              parent: Unit.find_by(yoksis_id: parent_yoksis_id),
              city: City.find_by(iso: 'TR-54')
            )

            if unit.save!
              puts "SUCCESS: #{unit.name} created"
            else
              puts "FAIL: #{unit.name} can not be created!"
            end
          when *programs
            unit = Unit.find_by(yoksis_id: parent_yoksis_id)
            program = Program.new(
              name: name,
              yoksis_id: yoksis_id,
              status: statuses[status.to_s].to_i,
              founded_at: founded_at ? founded_at.to_date : nil,
              instruction_type: instruction_types[instruction_type.to_s],
              foet_code: foet_code,
              language: language,
              duration: duration,
              type: unit_types[unit_type.to_s],
              unit: unit
            )

            if program.save!
              puts "SUCCESS: #{program.name} created"
              unit.programs << program
            else
              puts "FAIL: #{program.name} can not be created!"
            end
          else
            puts "We have no idea about this unit: #{unit}"
          end
        end
      end
    rescue Errno::ENOENT => e
      puts "File/path not found! #{e}"
    end
  end
end