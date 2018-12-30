# frozen_string_literal: true

class DuplicateService
  attr_reader :record, :prefixed_param

  def initialize(record, prefixed_param)
    @record = record
    @prefixed_param = prefixed_param
  end

  def duplicate
    clone_record = @record.dup
    clone_record.send(@prefixed_param).prepend('[Kopyası] ')
    clone_record.save
    clone_record
  end
end
