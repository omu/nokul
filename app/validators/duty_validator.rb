# frozen_string_literal: true

class DutyValidator < ActiveModel::Validator
  def validate(record)
    @duty = record
    @duties = record.employee.user.duties.where.not(id: @duty.id)

    date_validation if @duty.start_date? && @duty.end_date?
    restrict_duties if @duty.active?
  end

  def date_validation
    @duty.errors[:end_date] << message('invalid_end_date') if @duty.end_date < @duty.start_date
  end

  def restrict_duties
    add_to_base_error('multiple_active') if @duties.active.where(unit: @duty.unit).any?
    add_to_base_error('active_and_tenure') if !@duty.temporary && @duties.tenure.active.any?
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators duty])
  end

  def add_to_base_error(key)
    @duty.errors[:base] << message(key)
  end
end
