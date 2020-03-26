# frozen_string_literal: true

class UnitAccreditationStandardValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @accreditation_standard = record.accreditation_standard
    return unless @accreditation_standard.active?
    return unless already_exists?

    @accreditation_standard.errors.add(
      :base,
      I18n.t('defined', name: @record&.unit&.name, scope: %i[validators unit_accreditation_standard])
    )
  end

  def already_exists?
    UnitAccreditationStandard.includes(:accreditation_standard)
                .where.not(id: @record.id)
                .where(unit: @record.unit_id, accreditation_standards: { status: :active }).exists?
  end
end
