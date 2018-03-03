module Services
  module Yoksis
    module V1
      # client = Services::Yoksis::V1::AkademikPersonel.new
      class AkademikPersonel
        def initialize
          @client = Savon.client(
            wsdl: 'http://servisler.yok.gov.tr/ws/UniversiteAkademikPersonelv1?WSDL',
            convert_request_keys_to: :camelcase,
            logger: Rails.logger,
            basic_auth: [ENV['YOKSIS_USER'], ENV['YOKSIS_PASSWORD']]
          )
        end

        # alias: list_countries
        def get_mernis_uyruk
          @client.call(__method__).body[:get_mernis_uyruk_response][:referanslar]
        end
        alias_method :list_countries, :get_mernis_uyruk

        # alias: academic_staff_information
        def kullaniciya_gore_tc_kimlik_nodan_akademik_personel_bilgisiv1(
          queried_id_number,
          querier_id_number = ENV['YOKSIS_USER']
          )

          message = {
            'AKPER_TC_KIMLIK_NO' => queried_id_number,
            'SORGULAYAN_TC_KIMLIK_NO' => querier_id_number
          }

          @client.call(__method__, message: message)
                 .body[:kullaniciya_gore_tc_kimlik_nodan_akademik_personel_bilgisiv1_response][:akademik_personel]
        end
        alias_method :academic_staff_information, :kullaniciya_gore_tc_kimlik_nodan_akademik_personel_bilgisiv1

        # alias: list_academic_staff
        def kullaniciya_gore_universitedeki_akademik_personel_bilgisiv1(
          page,
          querier_id_number = ENV['YOKSIS_USER']
          )

          message = {
            'SAYFA' => page,
            'SORGULAYAN_TC_KIMLIK_NO' => querier_id_number,
          }

          @client.call(__method__, message: message)
                 .body[:kullaniciya_gore_universitedeki_akademik_personel_bilgisiv1_response][:akademik_personeller]
        end
        alias_method :list_academic_staff, :kullaniciya_gore_universitedeki_akademik_personel_bilgisiv1

        # alias: number_of_pages
        def kullaniciya_gore_universiteki_akademik_personel_sayfa_sayisiv1(
          querier_id_number = ENV['YOKSIS_USER']
          )

          message = {
            'SORGULAYAN_TC_KIMLIK_NO' => querier_id_number
          }

          @client.call(__method__, message: message)
                 .body[:kullaniciya_gore_universiteki_akademik_personel_sayfa_sayisiv1_response][:toplam_sayfa_sayisi]
                 .to_i
        end
        alias_method :number_of_pages, :kullaniciya_gore_universiteki_akademik_personel_sayfa_sayisiv1
      end
    end
  end
end
