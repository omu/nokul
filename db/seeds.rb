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
    yoksis_id, name, unit_type, parent_yoksis_id, status, language_code, founded_at, duration = unit.chomp.split('|')

    statuses = {
      'Aktif' => 0,
      'Yarı Pasif' => 1,
      'Pasif' => 2,
      'Kapalı' => 3,
      'Arşiv'=> 4
    }

    case unit_type
    when 'Üniversite'
      University.create!(
        name: name,
        university_type: 0,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at.to_date,
        city: City.find_by(iso: "TR-55")
      )
    when 'Fakülte'
      Faculty.create!(
        name: name,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at ? founded_at.to_date : nil,
        university: University.find_by(yoksis_id: parent_yoksis_id)
      )
    when 'Yüksekokul'
      Academy.create!(
        name: name,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at ? founded_at.to_date : nil,
        university: University.find_by(yoksis_id: parent_yoksis_id)
      )
    when 'Meslek Yüksekokulu'
      VocationalSchool.create!(
        name: name,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at ? founded_at.to_date : nil,
        university: University.find_by(yoksis_id: parent_yoksis_id)
      )
    when 'Enstitü'
      Institute.create!(
        name: name,
        yoksis_id: yoksis_id,
        status: statuses["#{status}"].to_i,
        founded_at: founded_at ? founded_at.to_date : nil,
        university: University.find_by(yoksis_id: parent_yoksis_id)
      )
    # when 'Bölüm'
    #   faculty = Faculty.find_by(yoksis_id: parent_yoksis_id)
    #   vocational_school = VocationalSchool.find_by(yoksis_id: parent_yoksis_id)
    #   academy = Academy.find_by(yoksis_id: parent_yoksis_id)
    #   university = University.find_by(yoksis_id: parent_yoksis_id)

    #   department = Department.new(name: name, yoksis_id: yoksis_id, active: active == 'Aktif' ? true : false, language_code: language_code)

    #   if faculty
    #     faculty.departments << department
    #   elsif vocational_school
    #     vocational_school.departments << department
    #   elsif academy
    #     academy.departments << department
    #   else
    #     puts "can not find the parent for #{name}"
    #   end
    # when 'Önlisans/Lisans Programı'
    #   faculty = Faculty.find_by(yoksis_id: parent_yoksis_id)
    #   vocational_school = VocationalSchool.find_by(yoksis_id: parent_yoksis_id)
    #   academy = Academy.find_by(yoksis_id: parent_yoksis_id)
    #   department = Department.find_by(yoksis_id: parent_yoksis_id)

    #   undergrad_program = UndergraduateProgram.new(name: name, yoksis_id: yoksis_id, active: active == 'Aktif' ? true : false, language_code: language_code)

    #   if faculty
    #     faculty.undergraduate_programs << undergrad_program
    #   elsif vocational_school
    #     vocational_school.undergraduate_programs << undergrad_program
    #   elsif academy
    #     academy.undergraduate_programs << undergrad_program
    #   elsif department
    #     department.undergraduate_programs << undergrad_program
    #   else
    #     puts "can not find the parent for #{name}"
    #   end
    else
      "We have no idea about this unit!"
    end
  end
end

# Create academic staff
# client = Services::Yoksis::V1::AkademikPersonel.new
# number_of_pages = client.number_of_pages

# for i in 1..number_of_pages
#   client.list_academic_staff(i).each do |academic_staff|
#     foo = academic_staff[:tc_kimlik_no]
#     bar = academic_staff[:adi]
#     baz = academic_staff[:soyadi]
#     taz = academic_staff[:kadro_unvan]
#     kaz = academic_staff[:birim_id]
#   end
# end
