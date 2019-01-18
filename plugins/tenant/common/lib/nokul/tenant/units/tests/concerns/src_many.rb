# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      module Tests
        module Concerns
          module SrcMany
            extend ActiveSupport::Concern

            included do
              test 'all active units must have an district_id' do
                assert_empty(units.select { |unit| unit.active? && unit.district_id.blank? })
              end

              test 'each unit must have an status_id' do
                assert_empty(units.select { |unit| unit.unit_status_id.blank? })
              end

              test 'active siblings must have uniq names' do
                skip

                offensive_units = []
                units.tree.values.each do |siblings|
                  seen = {}
                  siblings.each do |unit|
                    next unless unit.active?

                    offensive_units << unit if seen[unit.name]
                    seen[unit.name] = unit
                  end
                end
                assert_empty offensive_units
              end
            end
          end
        end
      end
    end
  end
end
