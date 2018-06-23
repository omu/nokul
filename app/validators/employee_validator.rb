# frozen_string_literal: true

class EmployeeValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t('active', scope: %i[validators employee]) if record.user.employees.active.present? && record.active?
  end
end
