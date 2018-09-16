# frozen_string_literal: true

class EmployeeValidator < ActiveModel::Validator
  def validate(record)
    employees = record.user.employees.where.not(id: record.id)
    record.errors[:base] << I18n.t('active', scope: %i[validators employee]) if employees.active.present? && record.active?
  end
end
