# frozen_string_literal: true

class DutyValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('duty.active_and_tenure') if record.employee.user.duties.tenure.active.present? && record.active?
  end
end
