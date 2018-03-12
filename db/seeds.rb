# This file is used to create initial data, that is needed for app to live.

# Create countries
File.open(Rails.root.join('db', 'countries.yml')) do |countries|
  countries.read.each_line do |country|
    iso, name, code = country.chomp.split('|')

    begin
      c = Country.create!(name: name, iso: iso, code: code)
      Rails.logger.info "Country created => #{c.name}"
    rescue ActiveModel::StrictValidationFailed
      Rails.logger.debug 'Invalid record, skipping!'
    end
  end
end

# Create regions
File.open(Rails.root.join('db', 'regions.yml')) do |regions|
  regions.read.each_line do |region|
    name, nuts_code = region.chomp.split('|')
    country = Country.find_by(iso: nuts_code[0..1])

    begin
      region = country.regions.create!(name: name, nuts_code: nuts_code)
      Rails.logger.info "Region created => #{region.name}"
    rescue ActiveModel::StrictValidationFailed
      Rails.logger.debug 'Invalid record, skipping!'
    end
  end
end

# Create cities
File.open(Rails.root.join('db', 'cities.yml')) do |cities|
  cities.read.each_line do |city|
    name, iso, nuts_code = city.chomp.split('|')
    region = Region.find_by(nuts_code: nuts_code[0..2])

    begin
      city = region.cities.create!(name: name, iso: iso, nuts_code: nuts_code, country: region.country)
      Rails.logger.info "City created => #{city.name}"
    rescue ActiveModel::StrictValidationFailed
      Rails.logger.debug 'Invalid record, skipping!'
    end
  end
end

# Create units [YOKSIS'ten alınan export'la birimleri oluştur.]
File.open(Rails.root.join('db', 'units.csv')) do |university_units|
  university_units.read.each_line do |unit|
    yoksis_id, name, unit_type, parent_yoksis_id, status, language, founded_at, duration = unit.chomp.split('|')

    # puts "processing unit with yoksis_id: #{yoksis_id}, name: #{name}, type: #{unit_type}, parent_yoksis_id: #{parent_yoksis_id}"

    statuses = {
      'Aktif' => 0,
      'Yarı Pasif' => 1,
      'Pasif' => 2,
      'Kapalı' => 3,
      'Arşiv'=> 4
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
      university = University.create!(
        name: name,
        university_type: 0,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at.to_date,
        city: City.find_by(iso: "TR-55")
      )

    when 'Fakülte', 'Yüksekokul', 'Meslek Yüksekokulu', 'Enstitü', 'Rektörlük', 'Araştırma ve Uygulama Merkezi'
      university = University.find_by(yoksis_id: parent_yoksis_id)
      university.units << Unit.new(
        name: name,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at ? founded_at.to_date : nil,
        university: university,
        type: unit_types["#{unit_type}"]
      )

    when 'Anabilim Dalı', 'Anasanat Dalı', 'Bölüm', 'Disiplinlerarası Anabilim Dalı', 'Bilim Dalı'
      arr = []
      arr << University.find_by(yoksis_id: parent_yoksis_id)
      arr << Unit.find_by(yoksis_id: parent_yoksis_id)
      arr = arr.compact.first

      if arr.is_a?(University)
        arr.units << Unit.new(
          name: name,
          yoksis_id: yoksis_id,
          status: statuses["#{status}"].to_i,
          founded_at: founded_at ? founded_at.to_date : nil,
          university: university,
          type: unit_types["#{unit_type}"]
        )
      elsif arr.is_a?(Unit)
        arr.university.units << Unit.new(
          name: name,
          yoksis_id: yoksis_id,
          status: statuses["#{status}"].to_i,
          founded_at: founded_at ? founded_at.to_date : nil,
          university: arr.university,
          type: unit_types["#{unit_type}"],
          parent: arr
        )
      end

    when 'Önlisans/Lisans Programı', 'Yüksek Lisans Programı', 'Doktora Programı', 'Disiplinlerarası Yüksek Lisans Programı', 'Disiplinlerarası Doktora Programı', 'Sanatta Yeterlilik Programı'
      unit = Unit.find_by(yoksis_id: parent_yoksis_id)

      unit.programs << Program.new(
        name: name,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at ? founded_at.to_date : nil,
        language: language,
        duration: duration,
        type: unit_types["#{unit_type}"],
        unit: unit
      )
    else
      puts "We have no idea about this unit: #{unit}"
    end
  end
end
