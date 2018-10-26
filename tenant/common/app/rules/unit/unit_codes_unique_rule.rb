# frozen_string_literal: true

class UnitCodesUniqueRule < Ruling::Rule
  synopsis 'Unit codes must be unique'
  subject :unit

  def self.setup(context)
    context.seen = {}
  end

  def before_rules
    skip if unit.code.blank?
  end

  def rule_code_must_unique(context)
    code = unit.code
    seen = context.seen
    return unless seen.key? code

    spot detail(code: code, context: context)
  ensure
    seen[itself] = unit
  end

  private

  FORMATTER = proc { |**param| format('%<label>24s: %<item>s', **param) }

  def detail(code:, _context:)
    [
      { label: 'Multiple code',  item: code      },
      { label: 'Offending unit', item: unit.name }
    ].map { |args| FORMATTER.call(**args) }.join "\n"
  end
end
