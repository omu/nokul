# frozen_string_literal: true

class ProspectiveStudentValidator < ActiveModel::Validator
  def validate(record)
    return unless record.registered?
    return unless record.unit_id_changed? || record.academic_term_id_changed?

    record.errors[:base] << message('unchangeable_variables')
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators prospective_student])
  end
end
