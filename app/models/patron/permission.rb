# frozen_string_literal: true

module Patron
  class Permission < ApplicationRecord
    # relations
    has_many :role_permissions, dependent: :destroy
    has_many :roles, through: :role_permissions

    # validations
    validates :name, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :identifier, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :description, length: { maximum: 65_535 }
  end
end
