# frozen_string_literal: true

module Patron
  class ScopeAssignment < ApplicationRecord
    # relations
    belongs_to :query_store
    belongs_to :user

    # validations
    validates :query_store_id, uniqueness: { scope: :user_id }
  end
end
