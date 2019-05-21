# frozen_string_literal: true

class LdapSynchronizationError < ApplicationRecord
  # relations
  belongs_to :ldap_synchronization

  # validations
  validates :description, length: { maximum: 65_535 }
end
