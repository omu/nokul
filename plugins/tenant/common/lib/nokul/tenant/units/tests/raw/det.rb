# frozen_string_literal: true

require_relative '../concerns'

module Nokul
  module Tenant
    module Units
      module Tests
        module Raw
          class DET < ActiveSupport::TestCase
            include Tests::Concerns::Many
            include Tests::Concerns::Tree

            attr_reader :units

            def setup
              @units = Tenant::Units.load_source 'raw/det'
            end
          end
        end
      end
    end
  end
end
