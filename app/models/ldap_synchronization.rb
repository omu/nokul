# frozen_string_literal: true

class LdapSynchronization < ApplicationRecord
  # enumerations
  enum status: { start: 0, pending: 1, success: 2, fail: 3 }

  # relations
  belongs_to :user
  has_many :ldap_synchronization_errors, dependent: :destroy
  # stores
  store :values, coder: JSON

  # validations
  validates :values, presence: true
end
