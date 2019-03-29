# frozen_string_literal: true

require_relative '../concerns'

module Nokul
  module Tenant
    module Units
      module Tests
        module Src
          class ALL < ActiveSupport::TestCase
            include Tests::Concerns::Many
            include Tests::Concerns::SrcMany
            include Tests::Concerns::Tree
            include Tests::Concerns::Abbreviatable

            attr_reader :units

            def setup
              @units = Tenant::Units.load_source 'src/all'
            end

            test 'all active units must have been encoded' do
              offensive_units = units.select(&:active?).select { |unit| unit.code.blank? }
              assert_empty offensive_units
            end

            test 'unit codes must be uniq' do
              seen = {}
              offensive_units = units.select(&:active?).select do |unit|
                seen.key?(unit.code).tap { seen[unit.code] = true }
              end
              assert_empty offensive_units
            end

            test 'all source files must be in clean state' do
              refute Tenant::Units.reproduce(quiet: true), <<~MSG

                Modified source files encountered when reproducing source files.
                This means that you have modified some file, or the reproduce logic
                has changed but you have forgotten to reproduce and commit.

                Please run "bin/rails tenant:units:reproduce" and commit changes.
              MSG
            end
          end
        end
      end
    end
  end
end
