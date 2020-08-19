# frozen_string_literal: true

module Actions
  module AcademicCalendar
    class Duplicate
      attr_reader :calendar, :clone

      def initialize(calendar)
        @calendar = calendar
        @clone    = calendar.dup
      end

      private_class_method :new

      class << self
        def call(calendar)
          new(calendar).call
        end
      end

      def call
        set_name
        set_committee_decisions
        set_calendar_events
        clone.save!

        clone
      end

      private

      def set_name
        clone.name.prepend('[Kopyası] ')
      end

      def set_committee_decisions
        clone.committee_decisions << calendar.committee_decisions
      end

      def set_calendar_events
        clone.calendar_events << calendar.calendar_events.map do |event|
          event = event.dup
          event.calendar_id = nil
          event
        end
      end
    end
  end
end
