module Services
  module Kps
    module Omu
      # client = Services::Kps::Omu::Kimlik.new
      # client.sorgula(42283908130)
      class Kimlik
        def initialize
          @client = Savon.client(wsdl: 'http://services.omu.edu.tr/kps/serviceV2.php?wsdl')
        end

        def sorgula(queried_id_number)
          message = { KimlikNo: queried_id_number.to_s }
          response = @client.call(
            :sorgula, message: message
          ).body[:sorgula_response][:return][:sorgula_result][:sorgu_sonucu][:bilesik_kutuk_bilgileri]

          # Türk ise - IE: 14674478966
          if response[:tc_vatandasi_kisi_kutukleri][:kisi_bilgisi][:durum_bilgisi][:durum].present?
            information_root = response[:tc_vatandasi_kisi_kutukleri][:kisi_bilgisi]
            id_number = information_root[:tc_kimlik_no]
            date_of_birth = (
              information_root[:temel_bilgisi][:dogum_tarih][:gun] + '.' +
              information_root[:temel_bilgisi][:dogum_tarih][:ay] + '.' +
              information_root[:temel_bilgisi][:dogum_tarih][:yil]
            ).to_date
            registered_to = information_root[:kayit_yeri_bilgisi][:il][:aciklama] + '/' +
                            information_root[:kayit_yeri_bilgisi][:ilce][:aciklama] + '/' +
                            information_root[:kayit_yeri_bilgisi][:cilt][:aciklama] + '/' +
                            information_root[:kayit_yeri_bilgisi][:aile_sira_no] + ':' +
                            information_root[:kayit_yeri_bilgisi][:birey_sira_no]

          # BlueCard ise - IE: 42283908130
          elsif response[:mavi_kartli_kisi_kutukleri][:kisi_bilgisi][:durum_bilgisi][:durum].present?
            information_root = response[:mavi_kartli_kisi_kutukleri][:kisi_bilgisi]
            id_number = information_root[:kimlik_no]
            date_of_birth = (
              information_root[:temel_bilgisi][:dogum_tarih][:gun] + '.' +
              information_root[:temel_bilgisi][:dogum_tarih][:ay] + '.' +
              information_root[:temel_bilgisi][:dogum_tarih][:yil]
            ).to_date
            registered_to = information_root[:ulke][:aciklama]

          # Yabancı ise - IE: 99878074596
          elsif response[:yabanci_kisi_kutukleri][:kisi_bilgisi][:durum_bilgisi][:durum].present?
            information_root = response[:yabanci_kisi_kutukleri][:kisi_bilgisi]
            id_number = information_root[:kimlik_no]
            date_of_birth = (
              information_root[:dogum_tarih][:gun] + '.' +
              information_root[:dogum_tarih][:ay] + '.' +
              information_root[:dogum_tarih][:yil]
            ).to_date

            registered_to = information_root[:uyruk][:aciklama]
          end

          # Common data for all
          first_name = information_root[:temel_bilgisi][:ad]
          last_name = information_root[:temel_bilgisi][:soyad]
          mothers_name = information_root[:temel_bilgisi][:anne_ad]
          fathers_name = information_root[:temel_bilgisi][:baba_ad]
          gender = information_root[:temel_bilgisi][:cinsiyet][:aciklama]
          place_of_birth = information_root[:temel_bilgisi][:dogum_yer]
          marital_status = information_root[:durum_bilgisi][:medeni_hal][:aciklama]
        end
      end
    end
  end
end
