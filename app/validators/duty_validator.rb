# frozen_string_literal: true

class DutyValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('active_and_tenure', scope: %i[validators duty]) if record.employee.user.duties.tenure.active.present? && record.active?
  end
end
