# frozen_string_literal: true

module ValidationTestModule
  extend ActiveSupport::Concern

  class_methods do
    def validates_presence_of(*attributes)
      attributes.each do |attribute|
        test "#{attribute} must be present (presence: true)" do
          object = class_name.delete_suffix('Test').constantize.take
          object.send("#{attribute}=", nil)
          assert_not object.valid?
          assert_not_empty object.errors[attribute]
        end
      end
    end

    def validates_presence_of_nested_model(attribute, ids: nil)
      test "nested model (#{attribute}) must be present" do
        ids ||= "#{attribute.to_s.singularize}_ids"
        object = class_name.delete_suffix('Test').constantize.take
        object.send("#{ids}=", nil)
        assert_not object.valid?
        assert_not_empty object.errors[attribute]
      end
    end

    def validates_uniqueness_of(*attributes)
      attributes.each do |attribute|
        test "#{attribute} must be unique (uniqueness: true)" do
          object = class_name.delete_suffix('Test').constantize.take
          duplicate_object = object.dup
          assert_not duplicate_object.valid?
          assert_not_empty duplicate_object.errors[attribute]
        end
      end
    end

    def validates_length_of(attribute, **args)
      args = { maximum: 255 } if args.blank?
      key = args.keys.first
      value = args.values.first

      value, error_key = if key.eql?(:is)
                           [value += 1, :wrong_length]
                         elsif key.eql?(:minimum)
                           [value -= 1, :too_short]
                         elsif key.eql?(:maximum)
                           [value += 1, :too_long]
                         end

      test "#{attribute} length must be #{args}" do
        object = class_name.delete_suffix('Test').constantize.take
        object.send("#{attribute}=", (0..value).map { ('a'..'z').to_a[rand(26)] }.join)
        assert_not object.valid?
        assert object.errors.details[attribute].map { |err| err[:error] }.include?(error_key)
      end
    end

    def validates_numericality_of(attribute)
      test "#{attribute} must be a number" do
        object = class_name.delete_suffix('Test').constantize.take
        object.send("#{attribute}=", 'some string')
        assert_not object.valid?
        assert object.errors.details[attribute].map { |err| err[:error] }.include?(:not_a_number)
      end
    end

    def validates_numerical_range(attribute, **args)
      key = args.keys.first
      value = args.values.first

      value = if key.eql?(:greater_than) || key.eql?(:less_than)
                value
              elsif key.eql?(:greater_than_or_equal_to)
                value -= 1
              elsif key.eql?(:less_than_or_equal_to)
                value += 1
              end

      test "#{attribute} must be #{key} #{value}" do
        object = class_name.delete_suffix('Test').constantize.take
        object.send("#{attribute}=", value)
        assert_not object.valid?
        assert object.errors.details[attribute].map { |err| err[:error] }.include?(key)
      end
    end
  end
end
