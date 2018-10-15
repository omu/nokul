# frozen_string_literal: true

module Xokul
  module Kps
    class Address
      delegate :dig, :[], to: :@response

      def initialize(id_number)
        @response = Connection.instance.get(
          '/kps/queries/addresses', params: { id_number: id_number }
        )
      end

      def full_informations
        @response
      end

      def address_type
        return current_address[:abroad_address]              if abroad?
        return current_address[:city_and_district_addresses] if city_and_district?
        return current_address[:village_address]             if village?
      end

      def model_data
        {
          full_address: current_address[:full_address],
          district:  district
        }
      end

      private

      def current_address
        @response[:current_address]
      end

      def district
        District.find_by(mernis_code: address_type.dig(:district, :code))
      end

      def abroad?
        current_address[:abroad_address].present?
      end

      def city_and_district?
        current_address[:city_and_district_addresses].present?
      end

      def village?
        current_address[:village_address].present?
      end
    end
  end
end
