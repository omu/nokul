# frozen_string_literal: true

module Nokul
  module Support
    class Structure < ::Module
      attr_accessor :members

      def initialize(members, error_on_undefined_members: false) # rubocop:disable Lint/MissingSuper
        self.members = (members = members.uniq)

        attr_accessor(*members)

        define_method(:initialize) do |**args|
          extend InstanceMethods

          _initialize(error_on_undefined_members: error_on_undefined_members, **args)
        end
      end

      def included(child)
        structure_members = members
        child.define_singleton_method :members do
          [*(defined?(super) ? super() : []), *structure_members].uniq
        end

        child.extend ClassMethods
      end

      def self.of(members)
        new(members, error_on_undefined_members: false)
      end

      def self.of!(members)
        new(members, error_on_undefined_members: true)
      end

      private_class_method :new

      module InstanceMethods
        def to_h(omit_if_nil: self.class.members)
          result = {}
          self.class.members.map do |member|
            next if (value = __send__(member)).nil? && Array((omit_if_nil || [])).any? { |key| key.to_sym == member }

            result[member] = value
          end
          result
        end

        def merge!(other)
          hash = _sanitize_and_coerce_merge_item(other)
          self.class.members.map do |member|
            next unless hash.key? member

            __send__ "#{member}=", hash[member]
          end
          self
        end

        SUFFIX_INDICATING_KEEP = '_'

        def merge_keep!(other)
          merge!(other)
          self.class.members.each do |member|
            next if (value = __send__(member)).nil?
            next unless (member_string = member.to_s).end_with? SUFFIX_INDICATING_KEEP

            original_member = member_string.chomp SUFFIX_INDICATING_KEEP
            next unless respond_to? "#{original_member}="

            __send__ "#{original_member}=", value
          end
          self
        end

        private

        def _sanitize_and_coerce_merge_item(other)
          case other
          when Hash then other
          when self.class then other.to_h
          when NilClass then raise ArgumentError, 'Merge item must not be nil'
          else raise ArgumentError, "Merge item type is invalid: #{other.class}"
          end
        end

        def _initialize(error_on_undefined_members: false, **args)
          args.each do |member, value|
            setter = "#{member}="
            next __send__(setter, value) if respond_to? setter

            raise(ArgumentError, "No such member: #{member}") if error_on_undefined_members
          end

          _after_initialize(**args)
        end

        def _after_initialize(**args)
          return unless respond_to? :after_initialize

          case method(:after_initialize).arity
          when 0 then  after_initialize
          when -1 then after_initialize(**args)
          else
            raise ArgumentError, 'No argument or variable number of arguments required for after_initialize'
          end
        end
      end

      module ClassMethods
        def new_from_hash(hash)
          new(**hash.symbolize_keys)
        end

        def included(base)
          super

          # Support mixins as in the following use cases

          case base
          when Class
            # module Base
            #   include Structure.of %i[foo bar]
            # end
            #
            # class Concrete
            #   include Base
            # end
            #
            base.class_attribute :members, default: [] unless base.respond_to? :members
          when Module
            # module Base
            #   include Structure.of %i[foo bar]
            # end
            #
            # module Intermediate
            #   include Base
            # end
            #
            # class Concrete
            #   include Intermediate
            # end
            #
            base.mattr_accessor :members, default: [] unless base.respond_to? :members
          else
            raise ArgumentError, "Unexpected base type during include: #{base.class}"
          end

          base.members += members
        end
      end
    end
  end
end
