# frozen_string_literal: true

module Tenant
  class Unit
    class Coder
      class Pool
        include Container.of %i[
          begins
          ends
          owner
          weight
          deny
          reserved
        ].freeze

        attr_reader :generator

        def after_initialize
          @generator = Coding::Generator.new(begins, ends: ends, deny: deny, memory: Memory.instance)
        end

        def score_of(unit)
          predicator = owner + '?'
          (unit.send(predicator) ? 1 : 0) * weight
        end

        def code
          generator.generate
        end
      end

      class Pools < Collection; end
    end
  end
end
