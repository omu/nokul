# frozen_string_literal: true

# Single YÖKSİS unit at raw form

module Nokul
  module Tenant
    module Units
      module Raw
        class YOKOne
          include Concerns::RawOne

          # Keep the order for YAML representation

          include Support::Structure.of %i[
            long_name
            english_name
            parent_unit_id
            osym_id
            period_of_study
          ].freeze + CODE_NAME_PAIRS = %i[
            status

            unit
            unit_type

            city
            district

            faculty
            instruction_language
            instruction_type
            university
            university_type
          ].freeze

          # Conveniency wrappers for code, name pairs.
          # E.g. unit_code['name'] => unit_code_name
          CODE_NAME_PAIRS.each do |name|
            define_method("#{name}_name") { pubic_send(name)[:name] }
            define_method("#{name}_code") { public_send(name)[:code] }
          end

          def tolerate!
            self.instruction_language = {} if instruction_language.blank?
            instruction_language[:code] ||= 1
            instruction_language[:name] ||= 'Türkçe'

            self.long_name = unit_name      if long_name.blank?
            self.long_name = 'unknown unit' if long_name.blank?
          end

          def id
            unit_code
          end

          def parent_id
            parent_unit_id
          end

          def name
            @name ||= long_name
          end

          def label
            "#{unit_code}    #{long_name}"
          end
        end
      end
    end
  end
end
