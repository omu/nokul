# frozen_string_literal: true

class ActivationServiceValidator < ActiveModel::Validator
  def validate(record)
    @record = record

    check_all_identity_serial_numbers
  end

  def check_all_identity_serial_numbers
    if blank_all_identity_serial_numbers?
      @record.errors[:base] << I18n.t('.cannot_be_blank', scope: %i[validators activation_service])
    elsif @record.document_no.blank?
      check_old_identity_serial_numbers
    end
  end

  def blank_all_identity_serial_numbers?
    @record.serial.blank? && @record.serial_no.blank? && @record.document_no.blank?
  end

  def check_old_identity_serial_numbers
    if @record.serial.present? && @record.serial_no.blank?
      @record.errors.add(:serial_no, :blank)
    elsif @record.serial.blank? && @record.serial_no.present?
      @record.errors.add(:serial, :blank)
    end
  end
end
