# frozen_string_literal: true

module Patron
  class RoleAssignment < ApplicationRecord
    # relations
    belongs_to :role
    belongs_to :user

    # validations
    validates :role_id, uniqueness: { scope: :user_id }
  end
end
