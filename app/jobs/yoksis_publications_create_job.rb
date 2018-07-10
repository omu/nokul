# frozen_string_literal: true

class YoksisPublicationsCreateJob < ApplicationJob
  queue_as :high

  # slow operation
  def perform(user)
    @response = Services::Yoksis::V1::Ozgecmis.new.certifications(user.id_number.to_i)
  end

  # callbacks
  after_perform do |job|
    user = job.arguments.first
    if @response[:sonuc][:durum_kodu].eql?('1') && @response[:arastirma_liste].present?
      response = [@response[:arastirma_liste]].flatten

      response.each do |study|
        user.certifications.create(
          yoksis_id: study[:s_id].to_i,
          type: study[:tur_id].to_i,
          name: study[:adi],
          content: study[:icerik],
          location: study[:yer],
          scope: study[:kapsam].to_i,
          duration: study[:sure],
          start_date: study[:bastar],
          end_date: study[:bittar],
          title: study[:unvan_ad].try(:capitalize_all),
          number_of_authors: study[:kisi_sayisi],
          city_and_country: study[:ulke_sehir],
          last_update: study[:guncelleme_tarihi],
          incentive_point: study[:tesv_puan],
          status: study[:aktif_pasif].to_i
        )
      end
    end
  end
end
