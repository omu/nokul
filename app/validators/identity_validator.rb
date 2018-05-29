# frozen_string_literal: true

class IdentityValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('identity.max_total', limit: 2) if record.user.identities.size >= 2
    record.errors[:base] << I18n.t('identity.max_total', limit: 1) if record.user.identities.formal.size >= 1
  end
end
