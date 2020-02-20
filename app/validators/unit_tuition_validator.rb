# frozen_string_literal: true

class UnitTuitionValidator < ActiveModel::Validator
  def validate(record)
    @unit_tuition = record
    @unit = record.unit
    @academic_term = record.academic_term
    return error_message if tuition_exists?
  end

  def tuition_exists?
    UnitTuition.where.not(id: @unit_tuition).where(unit: @unit).map(&:academic_term).uniq.include?(@academic_term)
  end

  def error_message
    @unit_tuition.tuition.errors.add(:base, I18n.t('defined', name: @unit.name, scope: %i[validators unit_tuition]))
  end
end
