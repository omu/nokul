# frozen_string_literal: true

require 'forwardable'

module Nokul
  module Support
    module Codification
      class Code
        extend Forwardable

        delegate %i[cycle next peek rewind +] => :@kernel

        def initialize(source, **options)
          @options = options
          @kernel  = setup(source).to_enum
        end

        def strings
          raise NotImplementedError
        end

        def to_s
          strings.affixed(**options)
        end

        protected

        attr_reader :kernel, :options

        def setup(source)
          source
        end
      end
    end
  end
end
