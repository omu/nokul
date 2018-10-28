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

      def personal_informations
        @response.dig(:blue_card_informations, :personal_informations).presence ||
          @response.dig(:citizenship_informations, :personal_informations).presence ||
          @response[:foreigner_informations].presence
      end

      def basic_informations
        personal_informations&.dig(:basic_informations) || {}
      end

      def status_informations
        personal_informations&.dig(:status_informations) || {}
      end

      def place_of_registry
        return unless (place = personal_informations&.dig(:place_of_registry))

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
    end
  end
end
