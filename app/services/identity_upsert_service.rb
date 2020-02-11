# frozen_string_literal: true

class IdentityUpsertService
  attr_reader :user, :identity, :params

  ATTRIBUTES_TO_COMPARE = %i[first_name last_name].freeze

  def initialize(user, **params)
    @user     = user
    @params   = params
    @identity = user&.identity
  end

  class << self
    def call(user, params)
      new(user, params).call
    end
  end

  def call
    updatable? ? update : create
  end

  private

  def create
    @user.identities.create!(params)
    update_related_records!
  end

  def update
    identity.update!(params) if exists?
  end

  def exists?
    identity.present?
  end

  def updatable?
    return false unless exists?

    ATTRIBUTES_TO_COMPARE.all? { |key| eql?(identity[key], params[key]) }
  end

  def eql?(str1, str2)
    str1.to_s.asciified.casecmp?(str2.to_s.asciified)
  end

  def update_related_records!
    user.reload

    return if user.students.active.none? || user.identity_id == identity.id

    user.students.active.each(&:set_identity)
  end
end
