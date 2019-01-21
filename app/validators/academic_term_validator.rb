# frozen_string_literal: true

class AcademicTermValidator < ActiveModel::Validator
  def validate(record)
    return if record.active?
    return if AcademicTerm.where.not(id: record.id).exists?(active: true)

    record.errors[:active] << I18n.t('active_check', scope: %i[validators academic_term])
  end
end
