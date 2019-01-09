# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      class Coder
        class Reservation
          include Support::Structure.of %i[
            key
            value
            reservation
          ].freeze
        end

        class Reservations < Support::Collection; end
      end
    end
  end
end
