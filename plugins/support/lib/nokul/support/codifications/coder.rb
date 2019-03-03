# frozen_string_literal: true

require_relative 'refinery'

module Nokul
  module Support
    module Codifications
      # :reek:TooManyInstanceVariables { max_variables: 5 }
      class Coder
        using Refinery

        Consumed = Class.new ::StandardError

        def initialize(begins, ends: nil, deny: nil, memory: nil)
          @begins = @current = Code.new begins
          @ends   = ends ? Code.new(ends, @begins.base) : @begins.ends

          @deny   = to_pattern(deny) if deny
          @memory = memory
        end

        def run
          code_string = try_run
          memory&.remember code_string
          code_string
        end

        def peek
          dup.run
        end

        def pool
          pool = range.to_a.map(&:to_s)
          return pool if no_restriction? # fast code path

          pool.reject { |code_string| notok?(code_string) }
        end

        protected

        attr_reader :begins, :ends, :current, :deny, :memory
        attr_writer :current

        def range
          Range.new begins, ends
        end

        def to_pattern(may_string_or_regexp)
          case may_string_or_regexp
          when Regexp then may_string_or_regexp
          when String then Regexp.new may_string_or_regexp
          else raise ArgumentError, 'Pattern must be a sting or Regexp object'
          end
        end

        def try_run
          loop do
            raise(Consumed, "Coder has been consumed at #{current}") if current > ends

            code_string = current.to_s
            self.current = current.succ
            return code_string unless notok? code_string
          end
        end

        def no_restriction?
          !deny && !memory
        end

        def notok?(code_string)
          return true if deny && code_string =~ deny
          return true if memory&.remember?(code_string)

          false
        end
      end
    end
  end
end
