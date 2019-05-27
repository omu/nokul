# frozen_string_literal: true

class LdapSyncError < ApplicationRecord
  # relations
  belongs_to :ldap_entity

  # validations
  validates :description, length: { maximum: 65_535 }
end
