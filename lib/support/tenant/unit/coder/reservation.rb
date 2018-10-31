# frozen_string_literal: true

module Tenant
  class Unit
    class Coder
      class Reservation
        include Container.of %i[
          key
          value
          reservation
        ].freeze
      end

      class Reservations < Collection; end
    end
  end
end
