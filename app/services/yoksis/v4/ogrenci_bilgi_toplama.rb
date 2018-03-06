module Services
  module Yoksis
    module V4
      # client = Services::Yoksis::V4::OgrenciBilgiToplama.new
      class OgrenciBilgiToplama
        def initialize
          wsdl = if Rails.env.production?
                   'https://servisler.yok.gov.tr/ws/ogrencibilgitoplamav4?WSDL'
                 else
                   'https://servisler.yok.gov.tr/ws/ogrencibilgitoplamav4Test?WSDL'
                 end

          @client = Savon.client(
            wsdl: wsdl,
            convert_request_keys_to: :camelcase,
            basic_auth: [ENV['YOKSIS_USER'], ENV['YOKSIS_PASSWORD']]
          )
        end
      end
    end
  end
end
