module Services
  module Kps
    module Omu
      # client = Services::Kps::Omu::Adres.new
      # client.sorgula(42283908130)
      class Adres
        def initialize
          @client = Savon.client(wsdl: 'http://services.omu.edu.tr/kps/serviceV2.php?wsdl')
        end

        def sorgula(queried_id_number)
          message = { KimlikNo: queried_id_number.to_s }
          response = @client.call(
            :adres_sorgula, message: message
          )
        end
      end
    end
  end
end
