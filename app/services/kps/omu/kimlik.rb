# frozen_string_literal: true

module Services
  module Kps
    module Omu
      # client = Services::Kps::Omu::Kimlik.new.sorgula(42283908130)
      class Kimlik
        def initialize
          @client = Savon.client(wsdl: 'http://services.omu.edu.tr/kps/serviceV2.php?wsdl')
        end

        def sorgula(queried_id_number)
          make_request(queried_id_number)

          err_args = %i[kisi_bilgisi hata_bilgisi aciklama]
          id_info_args = %i[kisi_bilgisi temel_bilgisi]
          marital_info_args = %i[kisi_bilgisi durum_bilgisi]
          date_of_birth_args = [:dogum_tarih, %i[gun ay yil]]

          blue_card = @response[:mavi_kartli_kisi_kutukleri]
          turkish_citizen = @response[:tc_vatandasi_kisi_kutukleri]
          foreign_citizen = @response[:yabanci_kisi_kutukleri]

          id_type = if blue_card.dig(*err_args).nil?
                      blue_card
                    elsif turkish_citizen.dig(*err_args).nil?
                      turkish_citizen
                    elsif foreign_citizen.dig(*err_args).nil?
                      foreign_citizen
                    end
          date_of_birth = if id_type == foreign_citizen
                            id_type.dig(*id_info_args[0], *date_of_birth_args[0]).values.join(' ')
                          else
                            id_type.dig(*id_info_args, *date_of_birth_args[0]).values.join(' ')
                          end

          # common behavior
          kimlik = id_type.dig(*id_info_args)

          identical_information = {
            first_name: kimlik[:ad],
            last_name: kimlik[:soyad],
            mothers_name: kimlik[:anne_ad],
            fathers_name: kimlik[:baba_ad],
            place_of_birth: kimlik[:dogum_yer],
            gender: kimlik[:cinsiyet][:aciklama],
            marital_status: id_type.dig(*marital_info_args)[:medeni_hal][:aciklama],
            registered_to: id_type.dig(id_info_args[0])[:kayit_yeri_bilgisi],
            date_of_birth: Date.strptime(date_of_birth, '%m %d %Y')
          }

          identical_information
        end

        def make_request(queried_id_number)
          message = { KimlikNo: queried_id_number.to_s }
          @response = @client.call(
            :sorgula, message: message
          ).body[:sorgula_response][:return][:sorgula_result][:sorgu_sonucu][:bilesik_kutuk_bilgileri]

          # return false if something went wrong, otherwise return the response
          @response[:hata_bilgisi].present? ? false : @response
        end
      end
    end
  end
end
