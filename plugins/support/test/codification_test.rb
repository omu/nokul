# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class CodificationTest < ActiveSupport::TestCase
        test 'API works' do
          %w[
            sequential_numeric_codes
            random_numeric_codes
            unsuffixed_user_names
            suffixed_user_names
          ].all? do |method|
            assert Codification.respond_to?(method.pluralize)
            assert Codification.respond_to?(method.singularize)
          end
        end
      end
    end
  end
end
