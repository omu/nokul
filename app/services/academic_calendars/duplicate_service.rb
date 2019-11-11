# frozen_string_literal: true

module AcademicCalendars
  class DuplicateService
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def self.call(calendar)
      new(calendar).duplicate
    end

    def duplicate
      clone_record = @record.dup
      clone_record.name.prepend('[Kopyası] ')
      clone_record.committee_decisions << @record.committee_decisions
      clone_record.calendar_events << initialize_events
      clone_record.save!
      clone_record
    end

    private

    def initialize_events
      record.calendar_events.map do |event|
        duplicated = event.dup
        duplicated.calendar_id = nil
        duplicated
      end
    end
  end
end
