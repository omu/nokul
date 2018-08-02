# frozen_string_literal: true

class AddressValidator < ActiveModel::Validator
  def validate(record)
    @addresses = record.user.addresses
    @record = record

    restrict_formal_addresses if record.formal?
    restrict_informal_addresses if record.informal?
  end

  private

  def restrict_formal_addresses(limit = 1)
    @record.errors[:base] << message('max_formal', limit) if @addresses.formal.any?
  end

  def restrict_informal_addresses(limit = 1)
    @record.errors[:base] << message('max_informal', limit) if @addresses.informal.any?
  end

  def message(key, limit)
    I18n.t(key, limit: limit, scope: %i[validators address])
  end
end
