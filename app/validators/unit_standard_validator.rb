# frozen_string_literal: true

class UnitStandardValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @standard = record.standard
    return unless already_exists?

    @standard.errors.add(
      :base,
      I18n.t('defined', name: @record&.unit&.name, scope: %i[validators unit_standard])
    )
  end

  def already_exists?
    UnitStandard.includes(:standard)
                .where.not(id: @record.id)
                .where(unit: @record.unit_id, standards: { status: :active }).exists?
  end
end
