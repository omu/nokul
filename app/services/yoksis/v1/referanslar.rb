module Services
  module Yoksis
    module V1
      # client = Services::Yoksis::V1::Referanslar.new
      # client.get_universite_turu
      class Referanslar
        attr_reader :request

        def initialize
          @client = Savon.client(
            wsdl: 'http://servisler.yok.gov.tr/ws/Referanslarv1?WSDL',
            convert_request_keys_to: :camelcase,
            log: false,
            log_level: :debug
          )
        end

        %i[
          aktiflik_durumu
          birim_turu
          ceza_turu
          giris_turu
          idari_birimler 
          ilce_getir
          il_getir
          kadro_gorev_unvan
          kod_bid
          mernis_cinsiyet
          mernis_ulke
          mernis_uyruk
          ogrenci_ayrilma_nedeni
          ogrenci_diploma_not_sistemi
          ogrenci_doykm
          ogrenci_engel_turu
          ogrenci_sehit_gazi_yakini
          ogrenci_giris_puan_turu
          ogrenci_giris_turu
          ogrencilik_statusu
          ogrenci_ogrencilik_hakki
          ogrenci_sinif
          ogrenim_dili
          ogrenim_turu
          personel_gorev
          universite_turu
        ].each { |method| define_method("get_#{method}") { send_request(__method__) } }

        def send_request(action_name)
          @response = @client.call(action_name)
          @response.body
        end
      end
    end
  end
end
