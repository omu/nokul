# frozen_string_literal: true

module CallbackTestModule
  extend ActiveSupport::Concern

  class_methods do
    %i[initialize find touch validation save create update destroy commit rollback].each do |method|
      define_method("has_#{method}_callback") do |key, kind, object: nil|
        test "has_#{method}_callback:#{kind} for #{key}" do
          object ||= class_name.delete_suffix('Test').constantize
          callbacks = object.send("_#{method}_callbacks")
          assert callbacks.select { |callback| callback.filter.eql?(key) && callback.kind.eql?(kind) }.any?
        end
      end
    end
  end
end
