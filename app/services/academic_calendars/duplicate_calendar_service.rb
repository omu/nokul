# frozen_string_literal: true

module AcademicCalendars
  class DuplicateCalendarService
    attr_reader :record, :prefixed_param

    def initialize(record, prefixed_param)
      @record = record
      @prefixed_param = prefixed_param
    end

    def duplicate
      clone_record = @record.dup
      clone_record.send(@prefixed_param).prepend('[Kopyası] ')
      clone_record.committee_decisions << @record.committee_decisions
      clone_record.save
      clone_record
    end
  end
end
