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
            serial: option[:serial],
            number: option[:number],
            document_number: option[:document_number]
          }
        )[:status]
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
