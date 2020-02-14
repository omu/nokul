# frozen_string_literal: true

class IdentityUpsertService
  attr_reader :user, :identity, :params, :type

  ATTRIBUTES_TO_COMPARE = %i[first_name last_name].freeze

  def initialize(user, identity = nil, **params)
    @user     = user
    @params   = { type: 'informal' }.merge(params)
    @type     = @params[:type]
    @identity = identity || user&.identity
  end

  class << self
    def call(user, identity = nil, **params)
      new(user, identity, params).call
    end
  end

  def call
    return false if params.empty?

    Identity.transaction do
      updatable? ? update : create
      update_related_records!
    end
  end

  private

  def create
    if exists?
      duplicated_identity = identity.dup
      duplicated_identity.assign_attributes(params)
      duplicated_identity.save!
    else
      @user.identities.public_send(type).create!(params)
    end
  end

  def update
    identity.update!(params) if exists?
  end

  def exists?
    identity.present?
  end

  def updatable?
    return false unless exists?
    return true  unless params.keys.any? { |key| ATTRIBUTES_TO_COMPARE.include?(key) }

    ATTRIBUTES_TO_COMPARE.all? { |key| eql?(identity[key], params[key]) }
  end

  def eql?(str1, str2)
    str1.to_s.asciified.casecmp?(str2.to_s.asciified)
  end

  def update_related_records!
    user.reload
    return if user.identity.id == identity.id

    update_students(identity_id: user.identity.id)
  end

  def update_students(**params)
    Student.transaction do
      user.students.active.where.not(params).each { |student| student.update!(params) }
    end
  end
end
