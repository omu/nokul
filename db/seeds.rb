# frozen_string_literal: true

# This file is used to create initial data, that is needed for app to live.

# create countries
File.open(Rails.root.join('db', 'static_data', 'countries.yml')) do |countries|
  countries.read.each_line do |country|
    iso, name, code = country.chomp.split('|')
    Country.create!(name: name, iso: iso, code: code)
  end
end

# create cities
File.open(Rails.root.join('db', 'static_data', 'cities.yml')) do |cities|
  cities.read.each_line do |city|
    name, iso, nuts_code = city.chomp.split('|')
    country = Country.find_by(iso: iso.split('-').first)
    country.cities.create!(name: name, iso: iso, nuts_code: nuts_code)
  end
end

# create districts
File.open(Rails.root.join('db', 'static_data', 'districts.yml')) do |districts|
  districts.read.each_line do |district|
    name, yoksis_id, city_code = district.chomp.split('|')
    iso = "TR-#{city_code}"
    city = City.find_by(iso: iso)
    city.districts.create!(name: name, yoksis_id: yoksis_id)
  end
end

# create titles
File.open(Rails.root.join('db', 'static_data', 'titles.yml')) do |titles|
  titles.read.each_line do |title|
    code, name, branch = title.chomp.split('|')
    Title.create!(name: name, code: code, branch: branch)
  end
end

# Fetch YOKSIS References
Rake::Task['yoksis:fetch_references'].invoke

# Import YOKSIS Departments
Rake::Task['yoksis:import_departments'].invoke

# Import Academic Staff from YOKSIS
# Rake::Task['yoksis:fetch_academic_staff'].invoke
