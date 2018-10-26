# frozen_string_literal: true

require_relative 'abbreviation'

module Tenant
  class Unit
    class UniqueAbbreviations < Ruling::Rule
      synopsis 'Unit abbreviations must be unique'
      subject :unit

      def self.setup(context)
        context.seen = {}
      end

      def before_rules
        skip if unit.abbreviation.blank?
      end

      def rule_abbreviation_itself_must_unique(context)
        itself = unit.abbreviation
        seen = context.seen
        return unless seen.key? itself

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

          spot detail(abbreviation: variant, variation: variation,
                      context: context)
        ensure
          seen[variant] = unit
        end
      end

      private

      def detail(abbreviation:, variation:, context:)
        formatter = proc { |**param| format('%<label>24s: %<item>s', **param) }
        [
          { label: 'Multiple abbreviation', item: abbreviation                         },
          { label: 'Offending unit', item: unit.name                                   },
          { label: 'Conflicting unit', item: context.seen[abbreviation].name           },
          { label: 'Variation', item: Abbreviation.description_of_variation(variation) }
        ].map { |args| formatter.call(**args) }.join "\n"
      end
    end

    class UniqueCodes < Ruling::Rule
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

      def detail(code:, _context:)
        formatter = proc { |**param| format('%<label>24s: %<item>s', **param) }
        [
          { label: 'Multiple code',  item: code      },
          { label: 'Offending unit', item: unit.name }
        ].map { |args| formatter.call(**args) }.join "\n"
      end
    end
  end
end
