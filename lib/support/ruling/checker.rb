# frozen_string_literal: true

module Ruling
  class Checker
    def initialize(subjects)
      @subjects   = subjects
      @violations = []
    end

    def check(*rule_classes, **param)
      rule_classes.each do |rule_class|
        check_by_one_rule(rule_class, **param)
      rescue Rule::SkipAll
        break
      end

      violations
    end

    protected

    attr_reader :subjects
    attr_accessor :violations

    private

    def check_by_one_rule(rule_class, **param)
      context = ActiveSupport::OrderedOptions.new

      setup_context_for(context, rule_class)

      subjects.each_with_index do |subject, index|
        context.nth = index + 1
        check_subject_by_rule(klass: rule_class, context: context,
                              subject: subject, param: param)
      rescue Rule::SkipOne
        nil
      end

      teardown_context_for(context, rule_class)
    end

    # :reek:LongParameterList { max_params: 4 }
    def check_subject_by_rule(klass:, context:, subject:, param: {})
      rule = klass.new(subject)
      rule.send :before_rules
      self.violations += rule.check(context, **param)
      rule.send :after_rules
    end

    def setup_context_for(context, rule_class)
      rule_class.setup(context)

      context.subjects            = subjects
      context.number_of_subjects  = subjects.size
    end

    def teardown_context_for(context, rule_class)
      rule_class.teardown(context)
    end
  end
end
