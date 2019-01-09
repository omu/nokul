# frozen_string_literal: true

require_relative '../concerns'

module Nokul
  module Tenant
    module Units
      module Tests
        module Src
          class YOK < ActiveSupport::TestCase
            include Tests::Concerns::Many
            include Tests::Concerns::SrcMany
            include Tests::Concerns::Tree
            include Tests::Concerns::Abbreviatable

            attr_reader :units

            def setup
              @units = Tenant::Units.load_source 'src/yok'
            end
          end
        end
      end
    end
  end
end
