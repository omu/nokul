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
            deny
            reserved
          ].freeze

          attr_reader :generator

          def after_initialize
            @generator = Support::Codifications::Generator.new(begins, ends: ends, deny: deny, memory: Memory.instance)
          end

          def score_of(unit)
            predicator = owner + '?'
            (unit.send(predicator) ? 1 : 0) * weight
          end

          def code
            generator.generate
          end
        end

        class Pools < Support::Collection; end
      end
    end
  end
end
