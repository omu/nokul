# frozen_string_literal: true

require 'test_helper'

module Patron
  class ScopeAssignmentTest < ActiveSupport::TestCase
    extend Support::Minitest::AssociationHelper
    extend Support::Minitest::ValidationHelper

    # relations
    belongs_to :query_store
    belongs_to :user
  end
end
