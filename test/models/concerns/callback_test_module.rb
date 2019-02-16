# frozen_string_literal: true

module CallbackTestModule
  extend ActiveSupport::Concern

  class_methods do
    # Possible keys => :before, :after, :around
    # has_initialize_callback(:method_name, :key)
    # has_find_callback(:method_name, :key)
    # has_touch_callback(:method_name, :key)
    # has_validation_callback(:method_name, :key)
    # has_save_callback(:method_name, :key)
    # has_create_callback(:method_name, :key)
    # has_update_callback(:method_name, :key)
    # has_destroy_callback(:method_name, :key)
    # has_commit_callback(:method_name, :key)
    # has_rollback_callback(:method_name, :key)

    %i[initialize find touch validation save create update destroy commit rollback].each do |method|
      define_method("has_#{method}_callback") do |key, kind, object: nil|
        test "#{object} has_#{method}_callback:#{kind} for #{key}" do
          object ||= class_name.delete_suffix('Test').constantize
          callbacks = object.send("_#{method}_callbacks")
          assert callbacks.select { |callback| callback.filter.eql?(key) && callback.kind.eql?(kind) }.any?
        end
      end
    end
  end
end
