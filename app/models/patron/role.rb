# frozen_string_literal: true

module Patron
  class Role < ApplicationRecord
    # search
    include PgSearch
    pg_search_scope(
      :search,
      against: %i[name identifier],
      using:   { tsearch: { prefix: true } }
    )

    # relations
    has_many :role_assignments, dependent: :destroy
    has_many :users, through: :role_assignments
    has_many :role_permissions, dependent: :destroy
    has_many :permissions, through: :role_permissions

    # validations
    validates :name, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :identifier, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :locked, inclusion: { in: [true, false] }
  end
end
