# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class CodificationTest < ActiveSupport::TestCase
        test 'API works' do
          %i[
            alternative_user_names
            random_numeric_codes
            sequential_numeric_codes
            suffixed_user_names
          ].all? { |method| assert Codification.respond_to?(method) }
        end
      end
    end
  end
end
