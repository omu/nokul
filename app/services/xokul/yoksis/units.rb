# frozen_string_literal: true

module Xokul
  module Yoksis
    module Units
      module_function

      def changes(day:, month:, year:)
        Connection.instance.get(
          '/yoksis/units/changes', params: { day: day, month: month, year: year }
        )
      end

      def universities
        Connection.instance.get '/yoksis/units/universities'
      end

      def units(unit_id:)
        Connection.instance.get(
          "/yoksis/units/#{__callee__}", params: { unit_id: unit_id }
        )
      end

      class << self
        alias subunits units
        alias programs units
      end
    end
  end
end
