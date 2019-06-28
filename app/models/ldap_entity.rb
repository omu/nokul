# frozen_string_literal: true

class LdapEntity < ApplicationRecord
  # enumerations
  enum status: { pending: 0, synchronized: 1, failed: 2 }

  # callbacks
  after_create_commit :start_sync
  before_validation :set_synchronized_at, if: :status_changed?

  # relations
  belongs_to :user
  has_many :ldap_sync_errors, dependent: :destroy

  # stores
  store :values, coder: JSON, accessors: Ldap::Entity.attributes

  # validations
  validates :values, presence: true
  validates :dn, presence: true

  def self.synchronized_for_user(user)
    LdapEntity.exists?(user_id: user.id, status: :synchronized)
  end

  def prev
    LdapEntity.where.not(id: id)
              .where(user_id: user_id, status: :synchronized)
              .order(synchronized_at: :desc)
              .first
  end

  def start_sync
    Ldap::SyncJob.perform_later(self)
  end

  private

  def set_synchronized_at
    self.synchronized_at = (synchronized? ? Time.current : nil)
  end
end
