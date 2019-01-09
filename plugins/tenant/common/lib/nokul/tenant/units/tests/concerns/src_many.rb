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
            end
          end
        end
      end
    end
  end
end
