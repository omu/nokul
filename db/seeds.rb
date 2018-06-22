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

# TODO: Below lines will not be in production
# Create sample calendar titles
CalendarTitle.create(name: 'Açılan derslerin ilanı')
CalendarTitle.create(name: 'Ders Kayıtları')
CalendarTitle.create(name: 'Derslerin Başlaması')
CalendarTitle.create(name: 'Ders Ekleme ve Bırakma')
CalendarTitle.create(name: 'Derslerin Bitimi')
CalendarTitle.create(name: 'Ara Sınav Haftası')
CalendarTitle.create(name: 'Yarıyıl Sonu Sınav Haftası')
CalendarTitle.create(name: 'Bütünleme Sınav Haftası')
CalendarTitle.create(name: 'Çift Anadal ve Yandal Başvuruları')
CalendarTitle.create(name: 'Çift Anadal ve Yandal Başvurularının Birimlerce Değerlendirilmesi ve İlanı')
CalendarTitle.create(name: 'Zorunlu Hazırlık Sınıfları Yabancı Dil Yeterlik Sınavı')
CalendarTitle.create(name: 'Yeterlik Sınav Sonuçlarının İlanı')
CalendarTitle.create(name: 'Hazırlık Sınıfları İçin Düzey Belirleme Sınavı')
CalendarTitle.create(name: 'Öğrencilerin WEB\'de Ders Kayıtları (Çiftanadal, Yandal Öğrencileri Dahil)')
CalendarTitle.create(name: 'Yabancı Dil Muafiyet Sınavları (5/i Dersleri İçin)')
CalendarTitle.create(name: 'Danışman Onay İşlemleri, Kontenjan Nedeni ile Açılamayan Seçmeli Dersteki Öğrencilerin Danışmanlarca Bir Başka Seçmeli Derse Aktarılması')
CalendarTitle.create(name: 'Mazeretli Ders Kaydı Başvuruları Son Günü')
CalendarTitle.create(name: 'Ara Mazeret Sınav Başvurusu Son Günü')
CalendarTitle.create(name: 'Yarıyıl Sonu Sınav Sonuçlarının İnternetten Girilmesinin Son Günü ve Sonuçların İlanı')
CalendarTitle.create(name: 'Bütünleme Sınav Sonuçlarının İnternetten Girilmesinin Son Günü')
CalendarTitle.create(name: 'Tek Ders Sınav Müracaatları')
CalendarTitle.create(name: 'Tek Ders Sınavları')
CalendarTitle.create(name: 'Tek Ders Sınav Sonuçlarının ÖİDB\'ye Gönderilmesi')
CalendarTitle.create(name: 'Doktora Yeterlik Sınavları')
CalendarTitle.create(name: 'Dönem Projesi Teslimi')
CalendarTitle.create(name: 'Öğrencilerin WEB\'de Ders Kayıtları')
CalendarTitle.create(name: 'Ek Sınav Müracaatlarının Son Günü (Önlisans öğrencileri için)')
CalendarTitle.create(name: 'Ek Sınav Tarihleri (Önlisans öğrencileri için)')
CalendarTitle.create(name: 'Ek Sınav Sonuçlarının ÖİDB\'ye Gönderilmesi')
