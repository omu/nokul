# frozen_string_literal: true

class ProspectiveStudentValidator < ActiveModel::Validator
  def validate(record)
    return unless record.user
    return unless registered?(record)
    return unless record.unit_id_changed? || record.academic_term_id_changed?

    record.errors[:base] << message('unchangeable_variables')
  end

  private

  def registered?(record)
    record.user.students.find_by(unit_id: unit(record))&.permanently_registered?
  end

  def unit(record)
    record.unit_id_changed? ? Unit.find(record.changes[:unit_id]&.first) : record.unit
  end

  def message(key)
    I18n.t(key, scope: %i[validators prospective_student])
  end
end
