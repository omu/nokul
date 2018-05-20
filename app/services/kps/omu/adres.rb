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
          message = { KimlikNo: queried_id_number.to_s }
          response = @client.call(
            :adres_sorgula, message: message
          ).body[:adres_sorgula_response][:return][:sorgula_result][:sorgu_sonucu][:kimlik_noile_kisi_adres_bilgileri]

          # return false if something went wrong.
          if response[:hata_bilgisi].present?
            raise IdNumberError
          else
            yerlesim_yeri = response[:yerlesim_yeri_adresi]
            address_root = if yerlesim_yeri[:il_ilce_merkez_adresi].present?
                             yerlesim_yeri[:il_ilce_merkez_adresi]
                           elsif yerlesim_yeri[:koy_adresi].present?
                             yerlesim_yeri[:koy_adresi]
                           elsif yerlesim_yeri[:yurt_disi_adresi].present?
                             yerlesim_yeri[:yurt_disi_adresi]
                           end
            # return a hash, ready to use for building an Address.
            address_information = {
              full_address: yerlesim_yeri[:acik_adres],
              city: address_root[:il],
              city_id: address_root[:il_kodu],
              district: address_root[:ilce],
              district_id: address_root[:ilce_kodu],
              neighbourhood: address_root[:mahalle],
              neighbourhood_id: address_root[:mahalle_kodu]
            }
            address_information
          end
        end
      end
    end
  end
end
