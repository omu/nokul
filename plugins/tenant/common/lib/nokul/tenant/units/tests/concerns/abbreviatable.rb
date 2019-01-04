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
                assert_empty units.invalid_units_due_to_abbreviation_missing
              end

              test 'only allowed characters can be used' do
                assert_empty units.invalid_units_due_to_abbreviation_characters
              end

              test 'should have no duplicates even with variants' do
                assert_empty units.invalid_units_due_to_abbreviation_duplicates
                assert_empty units.invalid_units_due_to_abbreviation_variations
              end

              test 'all abbreviated units must also have abbreviated parents' do
                offensive_units = []
                units.select { |unit| unit.abbreviation.present? }.each do |unit|
                  loop do
                    unit = units.get(unit.parent_id)
                    break unless unit

                    offensive_units << unit unless unit.abbreviation.present?
                  end
                end

                assert_empty offensive_units
              end

              test 'all abbreviated units must have an district_id' do
                assert_empty(units.select { |unit| unit.abbreviation.present? && unit.district_id.blank? })
              end
            end
          end
        end
      end
    end
  end
end
