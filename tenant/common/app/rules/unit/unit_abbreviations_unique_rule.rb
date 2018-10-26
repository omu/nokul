# frozen_string_literal: true

class UnitAbbreviationsUniqueRule < Ruling::Rule
  synopsis 'Unit abbreviations must be unique'
  subject :unit

  Abbreviation = Tenant::Unit::Abbreviation

  def self.setup(context)
    context.seen    = {}
    context.violate = {}
  end

  def before_rules
    skip if unit.abbreviation.blank?
  end

  def rule_abbreviation_itself_must_unique(context)
    itself = unit.abbreviation
    seen = context.seen
    return unless seen.key? itself

    return if already_violated? context

    spot detail(abbreviation: itself, variation: :itself,
                context: context)
  ensure
    seen[itself] = unit
  end

  def rule_abbreviation_variants_must_unique(context)
    itself = unit.abbreviation
    seen = context.seen
    Abbreviation.variants_excluding_itself(itself).each do |variation, variant|
      next unless seen.key?(variant)

      next if already_violated? context

      spot detail(abbreviation: variant, variation: variation,
                  context: context)
    ensure
      seen[variant] = unit
    end
  end

  private

  FORMATTER = proc { |**param| format('%<label>24s: %<item>s', **param) }

  def detail(abbreviation:, variation:, context:)
    [
      { label: 'Multiple abbreviation', item: abbreviation                         },
      { label: 'Offending unit', item: unit.name                                   },
      { label: 'Conflicting unit', item: context.seen[abbreviation].name           },
      { label: 'Variation', item: Abbreviation.description_of_variation(variation) }
    ].map { |args| FORMATTER.call(**args) }.join "\n"
  end

  def already_violated?(context)
    return true if (hash = context.violate)[unit]

    hash[unit] = true
    false
  end
end
