# frozen_string_literal: true

namespace :import do
  desc 'Imports administrative_units from db/static_data'
  task unit_groups: :environment do
    # unit_type grouping
    types_and_groups = {
      other: [
        'Eğitim Araştırma Hastanesi',
        'Rektörlük',
        'Üniversite',
        'YÖK'
      ],
      faculty: [
        'Fakülte',
        'Meslek Yüksekokulu',
        'Yüksekokul'
      ],
      department: [
        'Bölüm'
      ],
      major: [
        'Anabilim Dalı',
        'Anasanat Dalı',
        'Bilim Dalı',
        'Disiplinlerarası Anabilim Dalı',
        'Disiplinlerarası Anasanat Dalı',
        'Sanat Dalı'
      ],
      undergraduate_program: [
        'Önlisans Programı',
        'Önlisans/lisans Programı',
        'Tıpta Uzmanlık Programı'
      ],
      graduate_program: [
        'Bütünleşik Doktora Programı',
        'Disiplinlerarası Doktora Programı',
        'Disiplinlerarası Sanatta Yeterlilik Programı',
        'Disiplinlerarası Yüksek Lisans Programı',
        'Doktora Programı',
        'Sanatta Yeterlilik Programı',
        'Yüksek Lisans Programı'
      ],
      institute: [
        'Enstitü'
      ],
      research_center: [
        'Uygulama ve Araştırma Merkezi'
      ],
      committee: [
        'Diğer Komisyon',
        'Diğer Kurul',
        'Enstitü Disiplin Kurulu',
        'Enstitü Kurulu',
        'Enstitü Yönetim Kurulu',
        'Etik Kurul',
        'Fakülte Disiplin Kurulu',
        'Fakülte Kurulu',
        'Fakülte Yönetim Kurulu',
        'Konservatuvar Disiplin Kurulu',
        'Konservatuvar Kurulu',
        'Konservatuvar Yönetim Kurulu',
        'Senato',
        'Üniversite Disiplin Kurulu',
        'Üniversite Yönetim Kurulu',
        'Yüksekokul Disiplin Kurulu',
        'Yüksekokul Kurulu',
        'Yüksekokul Yönetim Kurulu'
      ],
      administrative: [
        'Anabilim Dalı Başkanlığı',
        'Anasanat Dalı Başkanlığı',
        'Başhekimlik',
        'Başmüdürlük',
        'Bölüm Başkanlığı',
        'Daire Başkanlığı',
        'Diğer İdari Birim',
        'Enstitü Müdürlüğü',
        'Enstitü Sekreterliği',
        'Fakülte Dekanlığı',
        'Fakülte Sekreterliği',
        'Konservatuvar Müdürlüğü',
        'Konservatuvar Sekreterliği',
        'Koordinatörlük',
        'Merkez Müdürlüğü',
        'Şube Müdürlüğü',
        'Üniversite Sekreterliği',
        'Yüksekokul Müdürlüğü',
        'Yüksekokul Sekreterliği'
      ]
    }

    types_and_groups.each do |group, type|
      UnitType.where(name: type).update(group: group)
    end
  end
end
