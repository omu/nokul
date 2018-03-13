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
