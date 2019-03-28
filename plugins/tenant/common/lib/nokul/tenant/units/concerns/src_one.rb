# frozen_string_literal: true

# Concern a single unit at source form

require_relative 'one'
require_relative 'predicable'

module Nokul
  module Tenant
    module Units
      module Concerns
        module SrcOne
          extend ActiveSupport::Concern

          include One
          include Predicable

          include Support::Structure.of %i[
            abbreviation
            code

            yoksis_id
            parent_yoksis_id
            parent_yoksis_id_

            detsis_id
            parent_detsis_id
            parent_detsis_id_

            unit_type_id
            unit_status_id
            district_id
            district_id_

            osym
            foet_code

            unit_instruction_language_id
            unit_instruction_language_id_
            unit_instruction_type_id

            duration
            founded_at

            issues
          ]

          def id
            yoksis_id || detsis_id
          end

          def parent_id
            parent_yoksis_id || parent_detsis_id
          end

          ANSI_COLOR_CODE = {
            cyan:   14,
            orange: 214,
            red:    197,
            yellow: 11
          }.freeze

          def _ansi_color_code
            return ANSI_COLOR_CODE[:cyan]   if academic?
            return ANSI_COLOR_CODE[:yellow] if administrative?
            return ANSI_COLOR_CODE[:orange] if special?

            ANSI_COLOR_CODE[:red]
          end

          def to_s
            "\e[1m\e[38;5;#{_ansi_color_code}m#{id}\e[0m  #{name}\e[0m"
          end
        end
      end
    end
  end
end
