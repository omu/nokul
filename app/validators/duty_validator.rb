# frozen_string_literal: true

class DutyValidator < ActiveModel::Validator
  def validate(record)
    # TODO: i18n
    record.errors[:base] << 'Aktif ve kadrolu personel kaydı var!' if record.employee.user.duties.tenure.active.present?
  end
end
