# frozen_string_literal: true

class IdentityValidator < ActiveModel::Validator
  def validate(record)
    @identities = record.user.identities
    @record = record

    restrict_formal_identities if record.formal? && record.student_id.nil?
    restrict_informal_identities if record.informal?
  end

  private

  def restrict_formal_identities(limit = 1)
    @record.errors[:base] << message('max_formal', limit) if @identities.formal.user_identity.present?
  end

  def restrict_informal_identities(limit = 1)
    @record.errors[:base] << message('max_informal', limit) if @identities.informal.any?
  end

  def message(key, limit)
    I18n.t(key, limit: limit, scope: %i[validators identity])
  end
end
