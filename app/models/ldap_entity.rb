# frozen_string_literal: true

class LdapEntity < ApplicationRecord
  # enumerations
  enum status: { start: 0, pending: 1, success: 2, fail: 3 }

  # callbacks
  after_create_commit :ldap_sync_start

  # relations
  belongs_to :user
  has_many :ldap_sync_errors, dependent: :destroy

  # stores
  store :values, coder: JSON

  # validations
  validates :values, presence: true
  validates :dn, presence: true

  def ldap_sync_start
    LdapSyncJob.perform_later(self)
  end
end
