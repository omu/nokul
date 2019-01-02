# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      module Tests
        module Concerns
          module Tree
            extend ActiveSupport::Concern

            included do
              test 'tree must have a root' do
                assert_not_nil units.root
              end

              test 'tree keys must not be blank' do
                assert_not units.tree.key? nil
                assert_not units.tree.key? ''
              end

              test "each unit's parent must exist except root" do
                skip
                missing_parents = units.select { |unit| units.get(unit.parent_id).nil? }
                missing_parents -= [units.root]

                assert_empty missing_parents
              end

              test 'all children and parent units must be placed at tree' do
                skip
                seen = (units.tree.values.flatten.map(&:id) + units.tree.keys).uniq.size
                assert_equal units.size, seen - 1
              end
            end
          end
        end
      end
    end
  end
end
