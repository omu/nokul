# frozen_string_literal: true

module Nokul
  module Support
    module Codifications
      class Memory
        def remember(_string, **)
          raise NotImplementedError
        end

        def remember?(_string, **)
          raise NotImplementedError
        end
      end

      class SimpleMemory < Memory
        attr_reader :store

        def initialize(initial = {})
          @store = initial.dup
        end

        def remember(string)
          store[string] = true
          string
        end

        def remember?(string)
          store.key? string
        end
      end
    end
  end
end
