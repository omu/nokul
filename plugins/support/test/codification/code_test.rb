# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class CodeTest < ActiveSupport::TestCase
        test 'concrete code class should implement required methods' do
          %i[
            convert
            emit
          ].each do |method|
            assert_raise(NotImplementedError) { Class.new(Code).new([]).send method }
          end
        end
      end
    end
  end
end
