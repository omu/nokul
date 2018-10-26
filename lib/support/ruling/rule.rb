# frozen_string_literal: true

require 'set'

require_relative 'violation'

module Ruling
  class Rule
    class_attribute :registery, default: Set.new

    class << self
      def setup(*); end

      def teardown(*); end

      def synopsis(synopsis)
        const_set :SYNOPSIS, synopsis
      end

      def subject(prefered_name)
        alias_attribute prefered_name, :subject
      end

      def runnable_methods
        public_instance_methods(true).grep(/^rule_/).map(&:to_s)
      end

      def inherited(klass)
        registery << klass
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
      self.class.runnable_methods.each do |method_name|
        invoke(method_name, context, **param)
        break unless issues.empty?
      end

      violations(context)
    end

    def spot(issue = '')
      issues << issue
    end

    def code
      self.class.name.demodulize
    end

    def synopsis
      self.class::SYNOPSIS
    end

    protected

    attr_reader :issues

    %i[after_initialize before_rules after_rules].each do |method|
      define_method(method) {}
    end

    def invoke(method_name, context, **param)
      result = invoke_by_arity(method_name, context, **param)
      spot if method_name.ends_with?('?') && !result
      result
    end

    def invoke_by_arity(method_name, context, **param)
      case method(method_name).arity
      when 0 then send method_name
      when 1 then send method_name, context
      when 2 then send method_name, context, param
      end
    end

    def violations(context)
      issues.map do |issue|
        Violation.new(rule: self, subject: subject,
                      context: context.dup, detail: issue)
      end
    end
  end
end
