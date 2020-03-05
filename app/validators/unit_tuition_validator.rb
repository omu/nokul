# frozen_string_literal: true

class UnitTuitionValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @tuition = record.tuition
    return unless already_exists?

    @tuition.errors.add(
      :base,
      I18n.t('defined', name: @record&.unit&.name, scope: %i[validators unit_tuition])
    )
  end

  def already_exists?
    UnitTuition.includes(tuition: :academic_term)
               .where.not(id: @record.id)
               .where(unit: @record.unit_id, tuitions: { academic_term_id: @tuition&.academic_term_id }).exists?
  end
end
