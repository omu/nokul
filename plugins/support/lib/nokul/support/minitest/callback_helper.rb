# frozen_string_literal: true

module Nokul
  module Support
    module Minitest
      module CallbackHelper
        CALLBACKS = %i[
          after_commit
          after_create
          after_destroy
          after_find
          after_initialize
          after_rollback
          after_save
          after_touch
          after_update
          after_validation
          around_create
          around_destroy
          around_save
          around_update
          before_create
          before_destroy
          before_save
          before_update
          before_validation
        ].freeze

        CALLBACKS.each do |callback|
          define_method(callback) do |action|
            test "has #{callback} for #{action}" do
              kind, method = callback.to_s.split('_')
              klass        = class_name.delete_suffix('Test').constantize
              callbacks    = klass.send("_#{method}_callbacks")
              assert callbacks.select { |cb| cb.filter.eql?(action.to_sym) && cb.kind.eql?(kind.to_sym) }.any?
            end
          end
        end
      end
    end
  end
end
