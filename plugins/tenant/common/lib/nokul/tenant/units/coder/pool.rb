# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      class Coder
        class Pool
          include Support::Structure.of %i[
            begins
            ends
            owner
            weight
            pattern
            reserved
          ].freeze

          attr_reader :coder

          def after_initialize
            @coder = Support::Codification.sequential_numeric_codes Range.new(begins.to_s, ends.to_s),
                                                                    memory: Memory.instance,
                                                                    post_process: Regexp.new(pattern)
          end

          def score_of(unit)
            predicator = owner + '?'
            (unit.send(predicator) ? 1 : 0) * weight
          end

          def code
            coder.run
          end
        end

        class Pools < Support::Collection; end
      end
    end
  end
end
