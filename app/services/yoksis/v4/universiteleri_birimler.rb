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
      end
    end
  end
end
