# frozen_string_literal: true

class AddressValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('address.max_total', limit: 5) if record.user.addresses.size >= 5
    record.errors[:base] << I18n.t('address.max_legal', limit: 1) if record.user.addresses.formal.size >= 1
  end
end
