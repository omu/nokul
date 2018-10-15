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
        return current_address[:abroad_address]            if abroad?
        return current_address[:city_and_district_address] if city_and_district?
        return current_address[:village_address]           if village?
      end

      def model_data
        {
          full_address: current_address[:full_address],
          district_id:  address_tyoe.dig(:district, :code)
        }
      end

      private

      def current_address
        @response[:current_address]
      end

      def abroad?
        current_address[:abroad_address].present?
      end

      def city_and_district?
        current_address[:city_and_district_address].present?
      end

      def village?
        current_address[:village_address].present?
      end
    end

    class Identity
      delegate :dig, :[], to: :@response

      def initialize(id_number)
        @response = Connection.instance.get(
          '/kps/queries/identities', params: { id_number: id_number }
        )
      end

      def full_informations
        @response
      end

      def id_type
        return @response[:blue_card_informations]  if blue_card?
        return @response[:citizenhip_informations] if citizenship?
        return @response[:foreigner_informations]  if foreigner?
      end

      def personal_informations
        id_type[:personal_informations]
      end

      def basic_informations
        personal_informations[:basic_informations]
      end

      def status_informations
        personal_informations[:status_informations]
      end

      def place_of_registry
        place = personal_informations[:place_of_registry]
        %w[city district volume].collect { |key| place.dig key, :description }
                                .join '/'
      end

      def model_data
        {
          **basic_informations,
          gender: basic_informations.dig(:gender, :code),
          marital_status: status_informations.dig(:marital_status, :code)
        }
      end

      private

      def blue_card?
        @response[:blue_card_informations].present?
      end

      def citizenship?
        @response[:citizenship_informations].present?
      end

      def foreigner?
        @response[:foreigner_informations].present?
      end
    end

    module_function

    def verify_identity(id_number:, first_name:, last_name:, year_of_birth:)
      Connection.instance.get(
        '/kps/verifications/identities',
        params: {
          id_number:     id_number,
          first_name:    first_name,
          last_name:     last_name,
          year_of_birth: year_of_birth
        }
      )
    end
  end
end
