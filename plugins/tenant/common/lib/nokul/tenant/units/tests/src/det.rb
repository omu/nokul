# frozen_string_literal: true

require_relative '../concerns'

module Nokul
  module Tenant
    module Units
      module Tests
        module Src
          class DET < ActiveSupport::TestCase
            include Tests::Concerns::Many
            include Tests::Concerns::SrcMany
            include Tests::Concerns::Abbreviatable

            attr_reader :units

            def setup
              @units = Tenant::Units.load_source 'src/det'
            end

            test 'parent yöksis ids should be correct' do
              yoksis_units = Tenant::Units.load_source 'src/yok'

              offensive_units = []
              units.each do |unit|
                next unless (id = unit.parent_yoksis_id)
                next if yoksis_units.get id

                offensive_units << unit
              end

              assert_empty offensive_units
            end
          end
        end
      end
    end
  end
end
