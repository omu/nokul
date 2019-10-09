# frozen_string_literal: true

class EmployeeValidator < ActiveModel::Validator
  def validate(record)
    employees = record.user.employees.where.not(id: record.id)
    return unless employees.active.present? && record.active?

    record.errors[:base] << I18n.t('active', scope: %i[validators employee])
  end
end
