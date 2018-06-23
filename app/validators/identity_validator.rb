# frozen_string_literal: true

class IdentityValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('max_total', limit: 2, scope: %i[validators identity]) if record.user.identities.size > 2
    record.errors[:base] << I18n.t('max_legal', limit: 1, scope: %i[validators identity]) if record.user.identities.formal.size >= 1 && record.formal?
  end
end
