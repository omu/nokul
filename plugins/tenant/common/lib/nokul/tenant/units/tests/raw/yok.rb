# frozen_string_literal: true

require_relative '../concerns'

module Nokul
  module Tenant
    module Units
      module Tests
        module Raw
          class YOK < ActiveSupport::TestCase
            include Tests::Concerns::Many
            include Tests::Concerns::Tree

            attr_reader :units

            def setup
              @units = Tenant::Units.load_source 'raw/yok'
            end

            test 'each unit must have a long name' do
              assert_empty(units.select { |unit| unit.long_name.blank? })
            end
          end
        end
      end
    end
  end
end
