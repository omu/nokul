# frozen_string_literal: true

# This file is used to create initial data, that is needed for app to live.

# create countries
File.open(Rails.root.join('db', 'static_data', 'countries.yml')) do |countries|
  countries.read.each_line do |country|
    name, alpha_2_code, alpha_3_code, numeric_code, mernis_code = country.chomp.split('|')
    Country.create!(
      name: name,
      alpha_2_code: alpha_2_code,
      alpha_3_code: alpha_3_code,
      numeric_code: numeric_code,
      mernis_code: mernis_code
    )
  end
end

# create cities
File.open(Rails.root.join('db', 'static_data', 'cities.yml')) do |cities|
  cities.read.each_line do |city|
    name, alpha_2_code = city.chomp.split('|')
    country = Country.find_by(alpha_2_code: alpha_2_code.split('-').first)
    country.cities.create!(name: name, alpha_2_code: alpha_2_code)
  end
end

# create districts
File.open(Rails.root.join('db', 'static_data', 'districts.yml')) do |districts|
  districts.read.each_line do |district|
    name, mernis_code, alpha_2_code, active = district.chomp.split('|')
    city = City.find_by(alpha_2_code: alpha_2_code)
    city.districts.create!(name: name, mernis_code: mernis_code, active: active.to_i)
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
Rake::Task['yoksis:fetch_academic_staff'].invoke

# Produced data for beta environment
if Rails.env.beta? || Rails.env.development?
  Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
    load seed
  end
end
