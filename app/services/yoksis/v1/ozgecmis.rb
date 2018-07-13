# frozen_string_literal: true

module Services
  module Yoksis
    module V1
      # client = Services::Yoksis::V1::Ozgecmis.new(12345678912)
      class Ozgecmis
        %i[
          get_arastirma_sertifka_bilgisi_v1
          get_makale_bilgisi_v1
          getir_proje_listesi
        ].each do |method|
          define_method(method) do
            @client.call(__method__, message: @message).body["#{__method__}_response".to_sym]
          end
        end

        def initialize(id_number)
          username = Rails.application.credentials.yoksis[:user]
          password = Rails.application.credentials.yoksis[:password]

          @client = Savon.client(
            wsdl: 'http://servisler.yok.gov.tr/ws/ozgecmisv1?WSDL',
            convert_request_keys_to: :camelcase,
            basic_auth: [username, password]
          )

          @message = message(username, password, id_number)
        end

        alias certifications get_arastirma_sertifka_bilgisi_v1
        alias articles get_makale_bilgisi_v1
        alias projects getir_proje_listesi

        private

        def message(username, password, id_number)
          {
            'parametre' => {
              'P_KULLANICI_ID' => username,
              'P_SIFRE' => password,
              'P_TC_KIMLIK_NO' => id_number
            }
          }
        end
      end
    end
  end
end
