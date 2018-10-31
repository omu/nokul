# frozen_string_literal: true

require_relative 'violation'

module Ruling
  class Rule
    class_attribute :rules, default: {}

    class << self
      def setup(*); end

      def teardown(*); end

      def synopsis(synopsis)
        const_set :SYNOPSIS, synopsis
      end

      def subject(prefered_name)
        alias_attribute prefered_name, :subject
      end

      def rule(name, skip: nil, &block)
        return if skip || !block_given?

        rules[name] = block
      end

      def inherited(child)
        child.rules = rules.dup
      end
    end

    class SkipOne < StopIteration; end

    class SkipAll < StopIteration; end

    def skip(arg = :one)
      case arg
      when :all then raise SkipAll
      when :one then raise SkipOne
      else           raise ArgumentError, 'Argument must be :all or :one (default)'
      end
    end

    attr_reader :subject

    def initialize(subject)
      @subject = subject
      @issues  = []

      after_initialize
    end

    def check(context, **param)
      self.class.rules.each do |name, rule|
        self.current_rule = name
        instance_exec(context, **param, &rule)
        self.current_rule = nil
        break unless issues.empty?
      end

      violations(context)
    end

    def spot(issue = nil)
      issue ||= "#{current_rule}: #{subject}" if current_rule
      issues << (issue || '')
    end

    def code
      self.class.name.demodulize
    end

    def synopsis
      self.class::SYNOPSIS
    end

    protected

    attr_reader :issues
    attr_accessor :current_rule

    %i[after_initialize before_rules after_rules].each do |method|
      define_method(method) {}
    end

    def violations(context)
      issues.map do |issue|
        Violation.new(rule: self, subject: subject,
                      context: context.dup, detail: issue)
      end
    end
  end
end
