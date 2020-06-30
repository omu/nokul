# frozen_string_literal: true

# Concern multiple units at raw form

require_relative 'many'

module Nokul
  module Tenant
    module Units
      module Concerns
        module RawMany
          extend ActiveSupport::Concern

          include Many

          def update
            units = (product = collection.produces).load_source

            each do |raw|
              unless (unit = units.get raw.id)
                units << (unit = product.collection.collects.new)
              end

              unit.merge_keep! raw_to_unit_hash(raw)
            end

            units
          end

          private

          def raw_to_unit_hash(raw)
            hash = {}
            mapping.each do |member, coercer|
              next unless coercer

              hash[member] = coercer.call(raw)
            end
            hash
          end
        end

        module Refinery
          FIX_AFTER_CAPITALIZE = {
            'Hast.' => 'Hastalıkları',
            'Pr.'   => 'Programı',
            'Üniv.' => 'Üniversitesi'
          }.freeze

          refine String do
            def capitalize_and_fix
              capitalized = capitalize_turkish_with_dashed_and_parenthesized
              FIX_AFTER_CAPITALIZE.each do |find, replace|
                capitalized.gsub!(/(?<!\w)#{Regexp.escape(find)}(?!\w)/, replace)
              end
              capitalized
            end

            def capitalize_turkish_with_dashed_and_parenthesized
              capitalize_turkish_with_parenthesized.split.map do |word|
                word.include?('-') ? word.capitalize_dashed_words : word
              end.join ' '
            end

            def capitalize_dashed_words
              split('-').map do |word|
                word.size > 1 ? word.capitalize_turkish : word
              end.join '-'
            end
          end
        end
      end
    end
  end
end
