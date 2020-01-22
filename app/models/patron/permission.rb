# frozen_string_literal: true

module Patron
  class Permission < ApplicationRecord
    # search
    include PgSearch::Model
    pg_search_scope(
      :search,
      against: %i[name identifier],
      using:   { tsearch: { prefix: true } }
    )

    # relations
    has_many :role_permissions, dependent: :destroy
    has_many :roles, through: :role_permissions
    has_many :users, through: :roles

    # validations
    validates :name, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :identifier, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :description, length: { maximum: 65_535 }

    def privileges_for_identifier
      Patron::PermissionBuilder.all[identifier]&.privileges || []
    end
  end
end
