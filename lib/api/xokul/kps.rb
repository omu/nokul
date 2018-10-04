# frozen_string_literal: true

module Xokul
  module Kps
    module_function

    def identity(id_number:)
      Connection.instance.get(
        '/kps/queries/identities', params: { id_number: id_number }
      )
    end

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
