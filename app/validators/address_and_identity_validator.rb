# frozen_string_literal: true

class AddressAndIdentityValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @records = record.user.public_send(record.class.name.tableize.to_sym)

    restrict_formal if record.formal? && record.try(:student_id).nil?
    restrict_informal if record.informal?
  end

  private

  def restrict_formal
    add_to_base_error('max_formal', 1) if @records.formal.present? || @records.formal.try(:user_identity).present?
  end

  def restrict_informal
    add_to_base_error('max_informal', 1) if @records.informal.any?
  end

  def message(key, limit)
    I18n.t(key, limit: limit, scope: %I[validators #{@record.class.name.downcase}])
  end

  def add_to_base_error(key, limit)
    @record.errors.add(:base, message(key, limit))
  end
end
