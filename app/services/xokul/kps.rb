# frozen_string_literal: true

module Xokul
  module Kps
    module_function

    def verify_foreign_national(**option)
      Connection.request(
        '/kps/verifications/foreign_nationals', params: {
          id_number: option.fetch(:id_number),
          first_name: option.fetch(:first_name),
          last_name: option.fetch(:last_name),
          day_of_birth: option.fetch(:day_of_birth),
          month_of_birth: option.fetch(:month_of_birth),
          year_of_birth: option.fetch(:year_of_birth)
        }
      )[:status]
    end

    # rubocop:disable Metrics/MethodLength
    def verify_identity_card(**option)
      Connection.request(
        '/kps/verifications/identity_cards', params: {
          id_number: option.fetch(:id_number),
          first_name: option.fetch(:first_name),
          last_name: option.fetch(:last_name),
          day_of_birth: option.fetch(:day_of_birth),
          month_of_birth: option.fetch(:month_of_birth),
          year_of_birth: option.fetch(:year_of_birth),
          card_serial_code: option.fetch(:card_serial_code),
          card_number: option.fetch(:card_number)
        }
      )[:status]
    end
    # rubocop:enable Metrics/MethodLength

    def verify_identity_number(**option)
      Connection.request(
        '/kps/verifications/identity_numbers', params: {
          id_number: option.fetch(:id_number),
          first_name: option.fetch(:first_name),
          last_name: option.fetch(:last_name),
          year_of_birth: option.fetch(:year_of_birth)
        }
      )[:status]
    end
  end
end
