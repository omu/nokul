# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      class Memory
        def remember(_string, **)
          raise NotImplementedError
        end

        def remember?(_string, **)
          raise NotImplementedError
        end

        def forget(_string, **)
          raise NotImplementedError
        end

        def learn(string, **options)
          return nil if remember?(string, **options)

          remember(string, **options)
          string
        end
      end

      class SimpleMemory < Memory
        def initialize(initial = {}) # rubocop:disable Lint/MissingSuper
          @store = initial.clone
        end

        def remember(string, **)
          store[string] = true
          string
        end

        def remember?(string, **)
          store.key? string
        end

        def forget(string, **)
          store.delete(string)
        end

        protected

        attr_reader :store
      end
    end
  end
end
