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
          identical_information = {}

          message = { KimlikNo: queried_id_number.to_s }
          response = @client.call(
            :sorgula, message: message
          ).body[:sorgula_response][:return][:sorgula_result][:sorgu_sonucu][:bilesik_kutuk_bilgileri]

          # return false if something went wrong.
          if response[:hata_bilgisi].present?
            false
          else
            # Türk ise - IE: 14674478966
            if response[:tc_vatandasi_kisi_kutukleri][:kisi_bilgisi][:durum_bilgisi][:durum].present?
              information_root = response[:tc_vatandasi_kisi_kutukleri][:kisi_bilgisi]
              identical_information[:date_of_birth] = (
                information_root[:temel_bilgisi][:dogum_tarih][:gun] + '.' +
                information_root[:temel_bilgisi][:dogum_tarih][:ay] + '.' +
                information_root[:temel_bilgisi][:dogum_tarih][:yil]
              ).to_date
              identical_information[:registered_to] = information_root[:kayit_yeri_bilgisi][:il][:aciklama] + '/' +
                                                      information_root[:kayit_yeri_bilgisi][:ilce][:aciklama] + '/' +
                                                      information_root[:kayit_yeri_bilgisi][:cilt][:aciklama] + '/' +
                                                      information_root[:kayit_yeri_bilgisi][:aile_sira_no] + ':' +
                                                      information_root[:kayit_yeri_bilgisi][:birey_sira_no]

            # BlueCard ise - IE: 42283908130
            elsif response[:mavi_kartli_kisi_kutukleri][:kisi_bilgisi][:durum_bilgisi][:durum].present?
              information_root = response[:mavi_kartli_kisi_kutukleri][:kisi_bilgisi]
              identical_information[:date_of_birth] = (
                information_root[:temel_bilgisi][:dogum_tarih][:gun] + '.' +
                information_root[:temel_bilgisi][:dogum_tarih][:ay] + '.' +
                information_root[:temel_bilgisi][:dogum_tarih][:yil]
              ).to_date
              identical_information[:registered_to] = information_root[:ulke][:aciklama]

            # Yabancı ise - IE: 99878074596
            elsif response[:yabanci_kisi_kutukleri][:kisi_bilgisi][:durum_bilgisi][:durum].present?
              information_root = response[:yabanci_kisi_kutukleri][:kisi_bilgisi]
              identical_information[:date_of_birth] = (
                information_root[:dogum_tarih][:gun] + '.' +
                information_root[:dogum_tarih][:ay] + '.' +
                information_root[:dogum_tarih][:yil]
              ).to_date

              identical_information[:registered_to] = information_root[:uyruk][:aciklama]
            end

            # Common data for all
            identical_information[:first_name] = information_root[:temel_bilgisi][:ad]
            identical_information[:last_name] = information_root[:temel_bilgisi][:soyad]
            identical_information[:mothers_name] = information_root[:temel_bilgisi][:anne_ad]
            identical_information[:fathers_name] = information_root[:temel_bilgisi][:baba_ad]
            identical_information[:place_of_birth] = information_root[:temel_bilgisi][:dogum_yer]

            gender_data = information_root[:temel_bilgisi][:cinsiyet][:aciklama]
            identical_information[:gender] = if gender_data.eql?('Kadın')
                                               Identity.genders[:female]
                                             elsif gender_data.eql?('Erkek')
                                               Identity.genders[:male]
                                             else
                                               Identity.genders[:other]
                                             end

            marital_status_data = information_root[:durum_bilgisi][:medeni_hal][:aciklama]
            identical_information[:marital_status] = if marital_status_data.eql?('Bekâr')
                                                       Identity.marital_statuses[:single]
                                                     elsif marital_status_data.eql?('Evli')
                                                       Identity.marital_statuses[:married]
                                                     elsif marital_status_data.eql?('Boşanmış')
                                                       Identity.marital_statuses[:divorced]
                                                     else
                                                       Identity.marital_statuses[:unknown]
                                                     end
            # return a hash, ready to use for building an Identity.
            return identical_information
          end
        end
      end
    end
  end
end
