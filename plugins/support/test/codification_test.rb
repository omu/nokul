# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class CodificationTest < ActiveSupport::TestCase
        test 'API works' do
          %i[
            sequential_numeric_codes
            suffixed_user_names
            alternative_user_names
          ].all? { |method| assert Codification.respond_to?(method) }
        end
      end
    end
  end
end
