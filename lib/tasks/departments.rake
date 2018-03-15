# rubocop:disable Metrics/BlockLength
namespace :yoksis do
  desc 'Imports YOKSIS departments from the given CSV file'
  task :departments do
    begin
      File.open(Rails.root.join('db', 'units.yml')) do |university_units|
        university_units.read.each_line do |unit|
          yoksis_id, name, unit_type, parent_yoksis_id, status, language, founded_at, duration = unit.chomp.split('|')

          statuses = {
            'Aktif' => 0,
            'Yarı Pasif' => 1,
            'Pasif' => 2,
            'Kapalı' => 3,
            'Arşiv' => 4
          }

          unit_types = {
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

          case unit_type.chomp
          when 'Üniversite'
            university = University.new(
              name: name,
              university_type: 1,
              yoksis_id: yoksis_id,
              status: statuses[status.to_s].to_i,
              founded_at: founded_at.to_date,
              city: City.find_by(iso: 'TR-55')
            )

            if university.save!
              puts "SUCCESS: #{university.name} created"
            else
              puts "FAIL: #{university.name} can not be created!"
            end

          when 'Fakülte', 'Yüksekokul', 'Meslek Yüksekokulu', 'Enstitü', 'Rektörlük', 'Araştırma ve Uygulama Merkezi'
            university = University.find_by(yoksis_id: parent_yoksis_id)
            unit = Unit.new(
              name: name,
              yoksis_id: yoksis_id,
              status: statuses[status.to_s].to_i,
              founded_at: founded_at ? founded_at.to_date : nil,
              university: university,
              type: unit_types[unit_type.to_s]
            )

            if unit.save!
              puts "SUCCESS: #{unit.name} created"
              university.units << unit
            else
              puts "FAIL: #{unit.name} can not be created!"
            end

          when 'Anabilim Dalı', 'Anasanat Dalı', 'Bölüm', 'Disiplinlerarası Anabilim Dalı', 'Bilim Dalı'
            arr = []
            arr << University.find_by(yoksis_id: parent_yoksis_id)
            arr << Unit.find_by(yoksis_id: parent_yoksis_id)
            arr = arr.compact.first

            if arr.is_a?(University)
              unit = Unit.new(
                name: name,
                yoksis_id: yoksis_id,
                status: statuses[status.to_s].to_i,
                founded_at: founded_at ? founded_at.to_date : nil,
                university: university,
                type: unit_types[unit_type.to_s]
              )

              if unit.save!
                puts "SUCCESS: #{unit.name} created"
                arr.units << unit
              else
                puts "FAIL: #{unit.name} can not be created!"
              end
            elsif arr.is_a?(Unit)
              unit = Unit.new(
                name: name,
                yoksis_id: yoksis_id,
                status: statuses[status.to_s].to_i,
                founded_at: founded_at ? founded_at.to_date : nil,
                university: arr.university,
                type: unit_types[unit_type.to_s],
                parent: arr
              )

              if unit.save!
                puts "SUCCESS: #{unit.name} created"
                arr.university.units << unit
              else
                puts "FAIL: #{unit.name} can not be created!"
              end
            end

          when 'Önlisans/Lisans Programı', 'Yüksek Lisans Programı', 'Doktora Programı',
            'Disiplinlerarası Yüksek Lisans Programı', 'Disiplinlerarası Doktora Programı',
            'Sanatta Yeterlilik Programı'
            unit = Unit.find_by(yoksis_id: parent_yoksis_id)

            program = Program.new(
              name: name,
              yoksis_id: yoksis_id,
              status: statuses[status.to_s].to_i,
              founded_at: founded_at ? founded_at.to_date : nil,
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
# rubocop:enable Metrics/BlockLength
