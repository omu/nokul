# frozen_string_literal: true

require 'yaml'

module Nokul
  module Tenant
    module Units
      module Tests
        module Concerns
          module Many
            extend ActiveSupport::Concern

            included do
              test 'no duplication at source' do
                source_size = YAML.load_file(units.collection.source).size
                assert_equal units.size, source_size
              end

              test 'each unit must have an id' do
                assert_empty(units.select { |unit| unit.id.blank? })
              end

              test 'each unit must have a parent id' do
                assert_empty(units.select { |unit| unit.parent_id.blank? })
              end
            end
          end
        end
      end
    end
  end
end
