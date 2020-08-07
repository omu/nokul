# frozen_string_literal: true

module Nokul
  module Support
    module Minitest
      module ValidationHelper
        SUFFIX = 'Test'

        def validates_presence_of(*attributes)
          attributes.each do |attribute|
            test "#{attribute} must be present (presence: true)" do
              object.public_send("#{attribute}=", nil)
              assert_not object.valid?
              assert_not_empty object.errors[attribute]
            end
          end
        end

        def validates_presence_of_nested_model(attribute, ids: nil)
          test "nested model (#{attribute}) must be present" do
            ids ||= "#{attribute.to_s.singularize}_ids"
            object.public_send("#{ids}=", nil)
            assert_not object.valid?
            assert_not_empty object.errors[attribute]
          end
        end

        def validates_uniqueness_of(*attributes)
          attributes.each do |attribute|
            test "#{attribute} must be unique (uniqueness: true)" do
              duplicate_object = object.dup
              assert_not duplicate_object.valid?
              assert_not_empty duplicate_object.errors[attribute]
            end
          end
        end

        def validates_length_of(attribute, **option) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
          option[:maximum] = 255 if option.blank?

          controls = {
            is:      { value: 1, error_key: :wrong_length },
            minimum: { value: -1, error_key: :too_short },
            maximum: { value: 1, error_key: :too_long }
          }

          key       = option.keys.first
          value     = option[key].to_i + controls.dig(key, :value).to_i
          error_key = controls.dig(key, :error_key)

          test "#{attribute} length must be #{option}" do
            object.public_send("#{attribute}=", (0..value).map { ('a'..'z').to_a[rand(26)] }.join)
            assert_not object.valid?
            assert object.errors.details[attribute].pluck(:error).include?(error_key)
          end
        end

        def validates_numericality_of(attribute)
          test "#{attribute} must be a number" do
            object.public_send("#{attribute}=", 'some string')
            assert_not object.valid?
            assert object.errors.details[attribute].pluck(:error).include?(:not_a_number)
          end
        end

        def validates_numerical_range(attribute, **option) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
          controls = {
            greater_than:             0,
            less_than:                0,
            greater_than_or_equal_to: -1,
            less_than_or_equal_to:    1
          }

          key   = option.keys.first
          value = option[key].to_i + controls[key].to_i

          test "#{attribute} must be #{key} #{value}" do
            object.public_send("#{attribute}=", value)
            assert_not object.valid?
            assert object.errors.details[attribute].pluck(:error).include?(key)
          end
        end

        def self.extended(base)
          base.define_method :object do
            @object ||= class_name.delete_suffix(SUFFIX).constantize.take
          end
        end
      end
    end
  end
end
