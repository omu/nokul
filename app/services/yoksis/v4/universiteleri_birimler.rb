# frozen_string_literal: true

module Services
  module Yoksis
    module V4
      # client = Services::Yoksis::V4::UniversiteBirimler.new
      class UniversiteBirimler
        def initialize
          wsdl = 'http://servisler.yok.gov.tr/ws/UniversiteBirimlerv4?WSDL'

          @client = Savon.client(
            wsdl: wsdl,
            convert_request_keys_to: :camelcase,
            basic_auth: [Rails.application.credentials.yoksis[:user], Rails.application.credentials.yoksis[:password]]
          )
        end

        # alias: list_countries
        def universiteleri_getirv4
          @client.call(__method__).body
        end
        alias universities universiteleri_getirv4

        # alias: programs
        def alt_birimdeki_programlari_getirv4(unit_id)
          message = { 'BIRIM_ID' => unit_id }

          @client.call(__method__, message: message)
                 .body[:alt_birimdeki_programlari_getirv4_response][:birimler]
        end
        alias programs alt_birimdeki_programlari_getirv4

        # alias: program_name
        def i_dden_birim_adi_getirv4(unit_id)
          message = { 'BIRIM_ID' => unit_id }

          @client.call(__method__, message: message)
                 .body[:i_dden_birim_adi_getirv4_response][:birim]
        end
        alias program_name i_dden_birim_adi_getirv4
      end
    end
  end
end
