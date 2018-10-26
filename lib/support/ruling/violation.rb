# frozen_string_literal: true

module Ruling
  class Violation
    attr_reader :rule, :subject, :context, :detail

    def initialize(rule:, subject:, context:, detail:)
      @rule    = rule
      @subject = subject
      @context = context
      @detail  = detail
    end

    # FIXME: Preliminary implementation

    LOCATION_STYLE = {
      order: proc do |violation|
        context = violation.context
        format('#%<nth>s/%<size>s', nth: context.nth, size: context.number_of_subjects)
      end,
      subject: proc do |violation|
        subject = violation.subject
        format('%<location>s',
               subject.respond_to?(:location) ? subject.location : subject.to_s)
      end
    }.freeze

    DEFAULT_STYLE = {
      location: :order
    }.freeze

    def format_by_style(**style)
      style.merge! DEFAULT_STYLE

      location = LOCATION_STYLE[style[:location]].call(self)
      message = format('%<location>s: %<code>s: %<synopsis>s.',
                       location: location, code: rule.code, synopsis: rule.synopsis)
      return message if detail.blank?

      message << "\n#{detail.gsub(/^/m, '  ')}"
    end

    def to_s
      format_by_style
    end
  end
end
