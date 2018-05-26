# frozen_string_literal: true

class EmployeeValidator < ActiveModel::Validator
  def validate(record)
    # TODO: i18n
    record.errors[:base] << 'Bu kullanıcının aktif bir personel kaydı var!' if record.user.employees.active.present?
  end
end
