# frozen_string_literal: true

module Xokul
  module Yoksis
    class Units < Endpoint
      configure do |config|
        config.namespace        = '/yoksis/units'
        config.upstream_version = '1'
      end

      def programs(sub_unit_id)
        conn.get :programs, params: { sub_unit_id: sub_unit_id }
      end

      def subunits(unit_id)
        conn.get :subunits, params: { unit_id: unit_id }
      end

      def units(unit_id)
        conn.get :/, params: { unit_id: unit_id }
      end

      def universities
        conn.get :universities
      end
    end
  end
end
