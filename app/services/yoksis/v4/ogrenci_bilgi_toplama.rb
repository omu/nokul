# frozen_string_literal: true

module Yoksis
  module V4
    # client = Yoksis::V4::OgrenciBilgiToplama.new
    class OgrenciBilgiToplama
      def initialize
        wsdl = if Rails.env.production? || Rails.env.beta?
                 'https://servisler.yok.gov.tr/ws/ogrencibilgitoplamav4?WSDL'
               else
                 'https://servisler.yok.gov.tr/ws/ogrencibilgitoplamav4Test?WSDL'
               end

        @client = Savon.client(
          wsdl: wsdl,
          convert_request_keys_to: :camelcase,
          basic_auth: [Rails.application.credentials.yoksis[:user], Rails.application.credentials.yoksis[:password]]
        )
      end
    end
  end
end
