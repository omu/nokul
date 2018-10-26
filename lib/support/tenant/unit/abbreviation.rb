# frozen_string_literal: true

module Tenant
  class Unit
    class Abbreviation
      %i[variants variants_excluding_itself].each do |method|
        define_singleton_method(method) do |abbreviation|
          new(abbreviation).send method
        end
      end

      VARIATIONS_UPCASE = {
        itself: 'abbreviation itself',
        dashless: 'abbreviation without dashes',
        asciified: 'ascii only abbreviation',
        dashless_asciified: 'ascii only abbreviation without dashes'
      }.freeze

      VARIATIONS_DOWNCASE = Hash[*
        VARIATIONS_UPCASE.map do |variation, desc|
          ["downcase_#{variation}".to_sym, "downcase #{desc}"]
        end.flatten
      ].freeze

      VARIATIONS = VARIATIONS_UPCASE.merge(VARIATIONS_DOWNCASE).freeze

      def self.description_of_variation(variation)
        VARIATIONS[variation]
      end

      attr_reader :itself, :variants

      def initialize(abbreviation)
        @itself = abbreviation
        @variants = ActiveSupport::OrderedOptions.new

        generate_all_unique_variations
      end

      def dashless
        itself.tr '-', ''
      end

      delegate :asciified, to: :itself

      # rubocop:disable Rails/Delegate (due to the false positive)
      def dashless_asciified
        dashless.asciified
      end
      # rubocop:enable Rails/Delegate

      VARIATIONS_UPCASE.keys.each do |variation|
        define_method("downcase_#{variation}") do
          send(variation).downcase(:turkic)
        end
      end

      def variants_excluding_itself
        (variants_excluding_itself = variants.dup).delete :itself
        variants_excluding_itself
      end

      private

      def generate_all_unique_variations
        VARIATIONS.keys.each do |variation|
          value = send variation
          variants[variation] = value unless variants.value? value
        end
      end
    end
  end
end
