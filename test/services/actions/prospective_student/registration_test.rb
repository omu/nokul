# frozen_string_literal: true

require 'test_helper'

module Actions
  module ProspectiveStudent
    class RegistrationTest < ActiveSupport::TestCase
      test 'can create a user and a student record' do
        assert_difference ['User.count', 'Student.count'], 1 do
          Actions::ProspectiveStudent::Registration.call(prospective_students(:jane))
        end
      end
    end
  end
end
