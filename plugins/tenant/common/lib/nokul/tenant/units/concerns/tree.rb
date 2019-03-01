# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      module Concerns
        module Tree
          extend ActiveSupport::Concern

          def tree
            @tree ||= begin
              tree = Hash.new { |hash, key| hash[key] = [] }
              each do |unit|
                tree[unit.parent_id] << unit
              end
              tree
            end
          end

          def root
            find { |unit| unit.parent_id.to_i.zero? }
          end

          def visit_unit(unit = root, level = 0, &block)
            return unless unit

            yield(unit, level) if block_given?

            return if (children = tree[unit.id]).empty?

            children.sort_by!(&:name)

            children.each do |child|
              visit_unit(child, level + 1, &block)
            end
          end

          def canonically_ordered
            result = []
            visit_unit { |unit| result << unit }
            result
          end

          def print_tree
            return if empty?

            visit_unit do |unit, level|
              puts ' ' * 4 * level + unit.to_s
            end
          end
        end
      end
    end
  end
end
