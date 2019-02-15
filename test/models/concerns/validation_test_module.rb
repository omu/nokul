# frozen_string_literal: true

module ValidationTestModule
  extend ActiveSupport::Concern

  class_methods do
    def validates_presence_of(attributes, object = nil)
      object ||= to_s.delete_suffix('Test')

      [attributes].compact.flatten.each do |attribute|
        test "#{attribute} must be present (presence: true) for #{object}" do
          random_object = object.constantize.take
          random_object.send("#{attribute}=", nil)
          assert_not random_object.valid?
          assert_not_empty random_object.errors[attribute]
        end
      end
    end

    def validates_uniqueness_of(attributes, object = nil)
      object ||= to_s.delete_suffix('Test')

      [attributes].compact.flatten.each do |attribute|
        test "#{attribute} must be unique (uniqueness: true) for #{object}" do
          duplicate_object = object.constantize.take.dup
          assert_not duplicate_object.valid?
          assert_not_empty duplicate_object.errors[attribute]
        end
      end
    end
  end
end
