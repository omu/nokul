# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      module Concerns
        module Abbreviatable
          extend ActiveSupport::Concern

          module Refinery
            refine String do
              def variations
                result  = [asciified, (dashless = tr('-', '')), dashless.asciified]
                result += result.map { |string| string.downcase(:turkic) }
                result.uniq
              end
            end

            refine Hash do
              def items_with_multiple_referers
                select { |key, value| key && value.size > 1 }
              end
            end
          end

          using Refinery

          def invalid_units_due_to_abbreviation_missing
            select { |unit| unit.live? && unit.abbreviation.blank? }
          end

          VALID_PATTERN = /^[ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWYZ0-9-]+$/.freeze

          def invalid_units_due_to_abbreviation_characters
            reject { |unit| unit.abbreviation.blank? }.reject { |unit| unit.abbreviation =~ VALID_PATTERN }
          end

          def invalid_units_due_to_abbreviation_duplicates
            by_abbreviation.items_with_multiple_referers
          end

          def invalid_units_due_to_abbreviation_variations
            by_abbreviation_variants.items_with_multiple_referers
          end

          private

          def by_abbreviation
            @by_abbreviation ||= classify(&:abbreviation)
          end

          def by_abbreviation_variants
            all_abbreviations = Hash.new { |hash, key| hash[key] = [] }

            each do |unit|
              next if (abbreviation = unit.abbreviation).blank?

              abbreviation.variations.each do |variant|
                all_abbreviations[variant] << unit
              end
            end

            all_abbreviations
          end
        end
      end
    end
  end
end
