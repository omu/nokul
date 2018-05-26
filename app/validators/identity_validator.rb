# frozen_string_literal: true

class IdentityValidator < ActiveModel::Validator
  def validate(record)
    # TODO: i18n
    record.errors[:base] << 'En fazla 2 adet kimlik ekleyebilirsiniz.' if record.user.identities.size > 2
    record.errors[:base] << 'En fazla 1 resmi kimliğiniz olabilir.' if record.user.identities.formal.present?
  end
end
