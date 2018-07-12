# frozen_string_literal: true

module Yoksis
  class CertificationsCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Services::Yoksis::V1::Ozgecmis.new(user.id_number.to_i).certifications
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      if @response[:sonuc][:durum_kodu].eql?('1') && @response[:arastirma_liste].present?
        response = [@response[:arastirma_liste]].flatten

        response.each do |study|
          user.certifications.create(
            yoksis_id: study[:s_id].try(:to_i),
            type: study[:tur_id].try(:to_i),
            name: study[:adi],
            content: study[:icerik],
            location: study[:yer],
            scope: study[:kapsam].try(:to_i),
            duration: study[:sure],
            start_date: study[:bastar],
            end_date: study[:bittar],
            title: study[:unvan_ad].try(:capitalize_all),
            number_of_authors: study[:kisi_sayisi],
            city_and_country: study[:ulke_sehir],
            last_update: study[:guncelleme_tarihi],
            incentive_point: study[:tesv_puan],
            status: study[:aktif_pasif].try(:to_i)
          )
        end
      end
    end
  end
end
