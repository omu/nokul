# frozen_string_literal: true

class AddressValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('max_total', limit: 5, scope: [:validators, :address]) if record.user.addresses.size > 5
    record.errors[:base] << I18n.t('max_legal', limit: 1, scope: [:validators, :address]) if record.user.addresses.formal.size >= 1 && record.formal?
  end
end
