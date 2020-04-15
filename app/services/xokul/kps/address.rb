# frozen_string_literal: true

module Xokul
  module Kps
    class Address
      delegate :dig, :[], to: :@response

      def initialize(id_number)
        @response = Connection.request(
          '/kps/queries/addresses',
          params: { id_number: id_number }
        ) || {}
      end

      def full_informations
        @response
      end

      def address_type
        current_address[:abroad_address].presence ||
          current_address[:city_and_district_addresses].presence ||
          current_address[:village_address].presence
      end

      def model_data
        {
          full_address: current_address[:full_address],
          district:     district
        }
      end

      private

      def current_address
        @response[:current_address] || {}
      end

      def district
        District.find_by(mernis_code: address_type.dig(:district, :code))
      end
    end
  end
end
