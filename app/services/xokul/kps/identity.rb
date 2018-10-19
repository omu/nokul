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
        return @response.dig(:blue_card_informations, :personal_informations)   if blue_card?
        return @response.dig(:citizenship_informations, :personal_informations) if citizenship?
        return @response[:foreigner_informations]                               if foreigner?
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
