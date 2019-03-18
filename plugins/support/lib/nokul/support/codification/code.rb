# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      class Code
        include Comparable

        def initialize(source = nil, **options)
          @options = options
          @source  = sanitize(source)

          setup if defined? setup

          self.kernel = initial_kernel
        end

        def <=>(other)
          kernel <=> other.kernel
        end

        def consumed?
          kernel >= last_kernel
        end

        def ending
          @ending ||= clone.tap { |instance| instance.kernel = last_kernel }
        end

        def range
          Range.new(self, ending)
        end

        def next
          clone.tap(&:next!)
        end

        alias succ next # so as to become a Range

        def next!
          raise Consumed if consumed?

          self.kernel = next_kernel
        end

        def to_s
          strings.affixed(**options)
        end

        protected

        attr_reader :source, :options
        attr_accessor :kernel

        def sanitize(source)
          source
        end

        def initial_kernel
          raise NotImplementedError
        end

        def next_kernel
          raise NotImplementedError
        end

        def last_kernel
          raise NotImplementedError
        end

        def strings
          raise NotImplementedError
        end

        module List
          def initial_kernel
            0
          end

          def next_kernel
            kernel.succ
          end

          def last_kernel
            @last_kernel ||= list.size - 1
          end

          def strings
            list[kernel]
          end

          protected

          attr_accessor :list
        end
      end
    end
  end
end
