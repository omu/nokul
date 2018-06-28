# frozen_string_literal: true

namespace :yoksis do
  # call a specific task by mentioning it's name and class, ie:
  # rake yoksis:reference['get_ogrenim_dili','UnitInstructionLanguage']
  # if you are using zsh you must escape braces though, ie:
  # rake yoksis:reference\['get_ogrenim_dili','UnitInstructionLanguage'\]

  desc 'fetch all references'
  task :fetch_references do
    {
      get_birim_turu: 'UnitType',
      get_ogrenim_dili: 'UnitInstructionLanguage',
      get_ogrenim_turu: 'UnitInstructionType',
      get_aktiflik_durumu: 'UnitStatus',
      get_universite_turu: 'UniversityType',
      get_personel_gorev: 'AdministrativeFunction',
      get_ogrenci_engel_turu: 'StudentDisabilityType',
      get_ogrenci_ayrilma_nedeni: 'StudentDropOutType',
      get_ogrenci_doykm: 'StudentEducationLevel',
      get_ogrenci_giris_puan_turu: 'StudentEntrancePointType',
      get_giris_turu: 'StudentEntranceType',
      get_ogrenci_sinif: 'StudentGrade',
      get_ogrenci_diploma_not_sistemi: 'StudentGradingSystem',
      get_ceza_turu: 'StudentPunishmentType',
      get_ogrenci_ogrencilik_hakki: 'StudentStudentshipStatus'
    }.each do |action, klass|
      Rake::Task['yoksis:fetch_reference'].invoke(action, klass)
      # https://stackoverflow.com/questions/4822020/why-does-a-rake-task-in-a-loop-execute-only-once
      Rake::Task['yoksis:fetch_reference'].reenable
    end
  end

  desc 'fetch an individual reference'
  task :fetch_reference, %i[soap_method klass] => [:environment] do |_, args|
    client = Services::Yoksis::V1::Referanslar.new
    api_name = client.class.to_s.split('::')[1]
    endpoint = client.class.to_s.split('::')[3]

    # make an api call
    response = client.send(args[:soap_method])

    # find the api action from response
    api_action = response.keys.first.to_s

    # calculate sha1 of the response
    sha1 = Digest::SHA1.hexdigest(response.to_s)

    # find if any records exists for this api_action
    current_response = YoksisResponse.find_by(name: api_name, endpoint: endpoint, action: api_action)
    # create records and log the action if no records found
    create_records(response, args[:klass].constantize) unless current_response

    # update the timestamp if we already have the same response
    if current_response && current_response.sha1.eql?(sha1)
      current_response.update(syncronized_at: Time.current)
    else
      create_yoksis_response(api_name, endpoint, api_action, sha1)
      # TODO: Notify operators to check changes at YOKSIS API. Never trust data coming from YOKSIS, check manually.
    end
  end

  def create_yoksis_response(api_name, endpoint, api_action, sha1)
    YoksisResponse.create(name: api_name, endpoint: endpoint, action: api_action, sha1: sha1)
  end

  def create_records(response, klass)
    response.values.first[:referanslar].each do |referans|
      klass.create!(name: referans[:ad], code: referans[:kod])
    end
  end
end
