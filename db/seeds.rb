# frozen_string_literal: true

# This file is used to create initial data, that is needed for app to live.

# Create countries
File.open(Rails.root.join('db', 'static_data', 'countries.yml')) do |countries|
  countries.read.each_line do |country|
    iso, name, code = country.chomp.split('|')
    Country.create!(name: name, iso: iso, code: code)
  end
end

# Create regions
File.open(Rails.root.join('db', 'static_data', 'regions.yml')) do |regions|
  regions.read.each_line do |region|
    name, nuts_code = region.chomp.split('|')
    country = Country.find_by(iso: nuts_code[0..1])
    country.regions.create!(name: name, nuts_code: nuts_code)
  end
end

# Create cities
File.open(Rails.root.join('db', 'static_data', 'cities.yml')) do |cities|
  cities.read.each_line do |city|
    name, iso, nuts_code = city.chomp.split('|')
    region = Region.find_by(nuts_code: nuts_code[0..2])
    region.cities.create!(name: name, iso: iso, nuts_code: nuts_code, country: region.country)
  end
end

# Create districts
File.open(Rails.root.join('db', 'static_data', 'districts.yml')) do |districts|
  districts.read.each_line do |district|
    name, yoksis_id, city_code = district.chomp.split('|')
    iso = "TR-#{city_code}"
    city = City.find_by(iso: iso)
    city.districts.create!(name: name, yoksis_id: yoksis_id)
  end
end

# Create academic staff
# client = Services::Yoksis::V1::AkademikPersonel.new
# number_of_pages = client.number_of_pages

# (1..number_of_pages).each do |page_number|
#   client.list_academic_staff(page_number).each do |academic_staff|
#     id_number = academic_staff[:tc_kimlik_no]
#     first_name = academic_staff[:adi]
#     last_name = academic_staff[:soyadi]
#     title = academic_staff[:kadro_unvan]
#     unit_id = academic_staff[:birim_id]
#   end
# end
