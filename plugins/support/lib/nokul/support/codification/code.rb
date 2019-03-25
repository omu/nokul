# frozen_string_literal: true

require 'forwardable'

module Nokul
  module Support
    module Codification
      class Code
        extend Forwardable

        delegate %i[cycle next peek rewind +] => :@enum

        def initialize(source, **options)
          @options = options
          @enum    = convert(source).to_enum
        end

        def to_s
          emit.join_affixed(**options)
        end

        protected

        attr_reader :enum, :options

        def convert(_source)
          raise NotImplementedError
        end

        def emit
          raise NotImplementedError
        end
      end

      class SimpleCode < Code
        def convert(source)
          source.must_be_any_of! [String]
        end

        def emit
          peek
        end
      end
    end
  end
end
