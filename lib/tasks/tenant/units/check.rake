# frozen_string_literal: true

Tenant.load_rules 'unit'

module Checkable
  def check_and_report(rules)
    headline

    (violations = check(rules)).each { |violation| puts violation }

    puts ''
    puts "#{violations.size} violations found."
    puts ''
  end

  def check(rules)
    checker = Ruling::Checker.new self
    checker.check(*rules)
  end
end

[YOK, DET, UNI, ALL].each { |collection_class| collection_class.include Checkable }

namespace :tenant do
  namespace :units do
    task :check_source do
      [YOK, DET, UNI].each do |collection_class|
        Support.abort_on_yaml_syntax_errors do
          collection_class.load.check_and_report [
            UnitAbbreviationsUniqueRule,
            UnitCodesUniqueRule
          ]
        end
      end
    end

    # TODO: add UnitAbbreviationsPresentRule when done

    task :check_output do
      Support.abort_on_yaml_syntax_errors do
        ALL.load.check_and_report [
          UnitCodesPresentRule,
          UnitAbbreviationsUniqueRule,
          UnitCodesUniqueRule
        ]
      end
    end

    desc 'Check output units data'
    task check: %i[check_source check_output]
  end
end
