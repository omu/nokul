# frozen_string_literal: true

module Services
  module Yoksis
    module V1
      # client = Services::Yoksis::V1::Ozgecmis.new
      class Ozgecmis
        def initialize
          @username = Rails.application.credentials.yoksis[:user]
          @password = Rails.application.credentials.yoksis[:password]

          @client = Savon.client(
            wsdl: 'http://servisler.yok.gov.tr/ws/ozgecmisv1?WSDL',
            convert_request_keys_to: :camelcase,
            basic_auth: [@username, @password]
          )
        end

        # TODO: Will refactor.
        def get_arastirma_sertifka_bilgisi_v1(id_number)
          message = {
            'parametre' => {
              'P_KULLANICI_ID' => @username,
              'P_SIFRE' => @password,
              'P_TC_KIMLIK_NO' => id_number
            }
          }

          @client.call(__method__, message: message).body["#{__method__}_response".to_sym]
        end
        alias certifications get_arastirma_sertifka_bilgisi_v1

        def get_makale_bilgisi_v1(id_number)
          message = {
            'parametre' => {
              'P_KULLANICI_ID' => @username,
              'P_SIFRE' => @password,
              'P_TC_KIMLIK_NO' => id_number
            }
          }

          @client.call(__method__, message: message).body["#{__method__}_response".to_sym]
        end

        alias articles get_makale_bilgisi_v1
      end
    end
  end
end
