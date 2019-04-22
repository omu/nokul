# frozen_string_literal: true

module Patron
  class ScopeAssignment < ApplicationRecord
    # relations
    belongs_to :query_store
    belongs_to :user
  end
end
