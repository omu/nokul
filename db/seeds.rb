# Create countries.
File.open("#{Rails.root}/db/countries.yml") do |countries|
  countries.read.each_line do |country|
    iso, name, code = country.chomp.split("|")
    Country.create!(:name => name, :iso => iso, :code => code)
  end
end

# Create academic staff
client = Services::Yoksis::V1::AkademikPersonel.new
number_of_pages = client.number_of_pages

for i in 1..number_of_pages
  client.list_academic_staff(i).each do |academic_staff|
    foo = academic_staff[:tc_kimlik_no]
    bar = academic_staff[:adi]
    baz = academic_staff[:soyadi]
    taz = academic_staff[:kadro_unvan]
    kaz = academic_staff[:birim_id]
  end
end