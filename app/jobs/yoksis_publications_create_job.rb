# frozen_string_literal: true

class YoksisPublicationsCreateJob < ApplicationJob
  queue_as :high

  # slow operation
  def perform(user)
    @response = Services::Yoksis::V1::Ozgecmis.new.certifications(user.id_number.to_i)
  end

  # TODO: WIP. Will refactor. Experimental code!
  # callbacks
  after_perform do |job|
    user = job.arguments.first
    if @response[:sonuc][:durum_kodu].eql?('1') && @response[:arastirma_liste].present?
      response = @response[:arastirma_liste]
      if response.is_a?(Hash)
        user.certifications.create(
          yoksis_id: response[:s_id].to_i,
          type: response[:tur_id].to_i,
          name: response[:adi],
          content: response[:icerik],
          location: response[:yer],
          scope: response[:kapsam].to_i,
          duration: response[:sure],
          start_date: response[:bastar],
          end_date: response[:bittar],
          title: response[:unvan_ad].capitalize_all,
          number_of_authors: response[:kisi_sayisi],
          city_and_country: response[:ulke_sehir],
          last_update: response[:guncelleme_tarihi],
          incentive_point: response[:tesv_puan],
          status: response[:aktif_pasif].to_i
        )
      else
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
            title: study[:unvan_ad].capitalize_all,
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
end
