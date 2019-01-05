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
              unless (unit = units.get raw.id.to_s)
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
            'Pr.' => 'Programı',
            'Üniv.' => 'Üniversitesi'
          }.freeze

          refine String do
            def capitalize_and_fix
              capitalized = capitalize_turkish_with_dashed_and_paranthesised
              FIX_AFTER_CAPITALIZE.each do |find, replace|
                capitalized.gsub!(/(?<!\w)#{Regexp.escape(find)}(?!\w)/, replace)
              end
              capitalized
            end

            # FIXME: This will eventually be replaced with a better implementation
            def capitalize_turkish_with_dashed_and_paranthesised
              capitalize_turkish_with_paranthesised.split.map do |word|
                next word unless word =~ /-/

                word.split('-').map do |dashed|
                  next dashed unless dashed.size > 1

                  dashed.capitalize_turkish
                end.join '-'
              end.join ' '
            end
          end
        end
      end
    end
  end
end
