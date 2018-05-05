# frozen_string_literal: true

module Services
  module Kps
    module Omu
      # client = Services::Kps::Omu::Adres.new.sorgula(42283908130)
      class Adres
        def initialize
          @client = Savon.client(wsdl: 'http://services.omu.edu.tr/kps/serviceV2.php?wsdl')
        end

        def sorgula(queried_id_number)
          address_information = {}

          message = { KimlikNo: queried_id_number.to_s }
          response = @client.call(
            :adres_sorgula, message: message
          ).body[:adres_sorgula_response][:return][:sorgula_result][:sorgu_sonucu][:kimlik_noile_kisi_adres_bilgileri]

          # return false if something went wrong.
          if response[:hata_bilgisi].present?
            false
          else
            # İl/ilçe merkezi adresi
            yerlesim_yeri_adresi = yerlesim_yeri_adresi
            if yerlesim_yeri_adresi[:il_ilce_merkez_adresi].present?
              address_root = yerlesim_yeri_adresi[:il_ilce_merkez_adresi]
            # Köy adresi
            elsif yerlesim_yeri_adresi[:koy_adresi].present?
              address_root = yerlesim_yeri_adresi[:koy_adresi]
            # Yurt dışı adresi
            elsif yerlesim_yeri_adresi[:yurt_disi_adresi].present?
              address_root = yerlesim_yeri_adresi[:yurt_disi_adresi]
            end

            # Common data for all
            address_information[:full_address] = yerlesim_yeri_adresi[:acik_adres]
            address_information[:city] = address_root[:il]
            address_information[:city_id] = address_root[:il_kodu]
            address_information[:district] = address_root[:ilce]
            address_information[:district_id] = address_root[:ilce_kodu]
            address_information[:neighbourhood] = address_root[:mahalle]
            address_information[:neighbourhood_id] = address_root[:mahalle_kodu]

            # return a hash, ready to use for building an Address.
            return address_information
          end
        end
      end
    end
  end
end
