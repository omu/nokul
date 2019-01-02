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
          # rubocop:disable Layout/AlignHash
          CONJUNCTIONS = %w[
            ama ancak dahi fakat ile lakin ve veya yani
          ].freeze

          PHRASE = {
            '(uzaktan Öğretim)' => '(Uzaktan Öğretim)',
            '(uzaktan Eğitim)'  => '(Uzaktan Eğitim)'
          }.freeze

          WORD = {
            'kktc' => 'KKTC',
            '(iö)' => '(İÖ)',
            '(yl)' => '(YL)',
            '(dr)' => '(DR)',
            'pr.'  => 'Programı'
          }.freeze
          # rubocop:enable Layout/AlignHash

          refine String do
            def titleize
              result = downcase(:turkic).split.map do |word|
                next word if CONJUNCTIONS.include?(word)
                next WORD[word] if WORD.include? word

                word.capitalize :turkic
              end.join ' '

              PHRASE.each do |find, replace|
                result.gsub! find, replace
              end

              result
            end
          end
        end
      end
    end
  end
end
