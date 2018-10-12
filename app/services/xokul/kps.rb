# frozen_string_literal: true

module Xokul
  module Kps
    class Identity
      delegate :dig, to: :@response

      attr_reader :blue_card, :citizenship, :foreigner

      def initialize(id_number)
        @response = Connection.instance.get(
          '/kps/queries/identities', params: { id_number: id_number }
        )

        @blue_card   = OpenStruct.new @response[:blue_card_informations]
        @citizenship = OpenStruct.new @response[:citizenship_informations]
        @foreigner   = OpenStruct.new @response[:foreigner_informations]
      end

      def full_informations
        @response
      end
    end

    module_function

    def address(id_number:)
      Connection.instance.get(
        '/kps/queries/addresses', params: { id_number: id_number }
      )
    end

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
