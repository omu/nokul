# frozen_string_literal: true

class AddressValidator < ActiveModel::Validator
  def validate(record)
    # TODO: i18n
    record.errors[:base] << 'En fazla 5 adet adres ekleyebilirsiniz.' if record.user.addresses.size >= 5
    record.errors[:base] << 'En fazla 1 ikamet adresiniz olabilir.' if record.user.addresses.formal.size >= 1
  end
end
