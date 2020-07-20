# frozen_string_literal: true

require 'test_helper'

class LdapEntityTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::EnumerationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # enums
  enum status: { pending: 0, synchronized: 1, failed: 2 }

  # relations
  belongs_to :user
  has_many :ldap_sync_errors, dependent: :destroy

  # validations: presence
  validates_presence_of :values
  validates_presence_of :dn

  # callbacks
  after_commit :sync
  before_validation :set_synchronized_at
end
