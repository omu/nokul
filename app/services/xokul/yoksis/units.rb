# frozen_string_literal: true

module Xokul
  module Yoksis
    module Units
      module_function

      def changes(day:, month:, year:)
        Connection.request(
          '/yoksis/units/changes', params: { day: day, month: month, year: year }
        )
      end

      def programs(sub_unit_id:)
        Connection.request(
          '/yoksis/units/programs', params: { sub_unit_id: sub_unit_id }
        )
      end

      def universities
        Connection.request '/yoksis/units/universities'
      end

      def unit_name_from_id(unit_id:)
        Connection.request(
          '/yoksis/units/names', params: { unit_id: unit_id }
        )
      end

      def subunits(unit_id:)
        Connection.request(
          '/yoksis/units/subunits', params: { unit_id: unit_id }
        )
      end
    end
  end
end
