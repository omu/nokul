# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      module Tests
        module Concerns
          module Abbreviatable
            extend ActiveSupport::Concern

            included do
              test 'all active units must be abbreviated' do
                skip # FIXME
                assert_empty units.invalid_units_due_to_abbreviation_missing
              end

              test 'only allowed characters can be used' do
                assert_empty units.invalid_units_due_to_abbreviation_characters
              end

              test 'should have no duplicates even with variants' do
                assert_empty units.invalid_units_due_to_abbreviation_duplicates
                assert_empty units.invalid_units_due_to_abbreviation_variations
              end
            end
          end
        end
      end
    end
  end
end
