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

      %i[
        programs
        subunits
        units
      ].each do |method|
        define_method(method) do |unit_id:|
          Connection.instance.get(
            "/yoksis/units/#{method}", params: { unit_id: unit_id }
          )
        end
      end
    end
  end
end
