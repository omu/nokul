module Services
  module Yoksis
    module V1
      # client = Services::Yoksis::V1::AkademikPersonel.new
      # client.get_mernis_uyruk({})
      # client.kullaniciya_gore_tc_kimlik_nodan_akademik_personel_bilgisiv1({"AKPER_TC_KIMLIK_NO" => 14674478966, "SORGULAYAN_TC_KIMLIK_NO" => 41242414552})
      class AkademikPersonel
        def initialize
          @client = Savon.client(
            wsdl: 'http://servisler.yok.gov.tr/ws/UniversiteAkademikPersonelv1?WSDL',
            log: false,
            log_level: :debug,
            basic_auth: ['41242414552', '876ytr']
          )
        end

        %i[
          get_mernis_uyruk
          kullaniciya_gore_tc_kimlik_nodan_akademik_personel_bilgisiv1
          kullaniciya_gore_universitedeki_akademik_personel_bilgisiv1
          kullaniciya_gore_universitedeki_akademik_personel_sayfa_sayisiv1
        ].each { |method| define_method(method) { |argv| send_request(__method__, argv) } }

        def send_request(action_name, argv)
          @response = @client.call(action_name, message: argv)
          @response.body
        end
      end
    end
  end
end
