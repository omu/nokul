# frozen_string_literal: true

module Xokul
  module Kps
    module Verification
      module_function

      # rubocop:disable Metrics/MethodLength
      def id_card(**option)
        Connection.request(
          '/kps/verifications/id_cards', params: {
            id_number: option.fetch(:id_number),
            first_name: option.fetch(:first_name),
            last_name: option.fetch(:last_name),
            day_of_birth: option.fetch(:day_of_birth),
            month_of_birth: option.fetch(:month_of_birth),
            year_of_birth: option.fetch(:year_of_birth),
            card_serial: option[:card_serial],
            card_number: option[:card_number]
          }
        )[:status]
      end
      # rubocop:enable Metrics/MethodLength

      def id_number(**option)
        Connection.request(
          '/kps/verifications/id_numbers', params: {
            id_number: option.fetch(:id_number),
            first_name: option.fetch(:first_name),
            last_name: option.fetch(:last_name),
            year_of_birth: option.fetch(:year_of_birth)
          }
        )[:status]
      end
    end
  end
end
