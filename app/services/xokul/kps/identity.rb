# frozen_string_literal: true

module Xokul
  module Kps
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
        return @response[:blue_card_informations]   if blue_card?
        return @response[:citizenship_informations] if citizenship?
        return @response[:foreigner_informations]   if foreigner?
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
        %i[volume district city].collect { |key| place.dig key, :description }
                                .join '/'
      end

      def model_data
        {
          **basic_informations,
          registered_to: place_of_registry,
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
  end
end
