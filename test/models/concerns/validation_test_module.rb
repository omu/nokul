# frozen_string_literal: true

module ValidationTestModule
  extend ActiveSupport::Concern

  class_methods do
    # Examples
    # validates_presence_of :name
    # validates_presence_of(:name, units(:omu))
    # validates_presence_of(%i[name code year])
    def validates_presence_of(attributes, object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take

      [attributes].compact.flatten.each do |attribute|
        test "#{attribute} must be present (presence: true) for #{object}" do
          object.send("#{attribute}=", nil)
          assert_not object.valid?
          assert_not_empty object.errors[attribute]
        end
      end
    end

    # Examples
    # validates_presence_of_nested_model :lecturers
    # validates_presence_of_nested_model(:lecturers, 'employee_ids')
    def validates_presence_of_nested_model(attribute, ids = nil, object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take
      ids ||= "#{attribute.to_s.singularize}_ids"

      test "nested model (#{attribute}) must be present for #{object}" do
        object.send("#{ids}=", nil)
        assert_not object.valid?
        assert_not_empty object.errors[attribute]
      end
    end

    # Examples
    # validates_uniqueness_of :name
    # validates_uniqueness_of(%i[name code year])
    def validates_uniqueness_of(attributes, object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take

      [attributes].compact.flatten.each do |attribute|
        test "#{attribute} must be unique (uniqueness: true) for #{object}" do
          duplicate_object = object.dup
          assert_not duplicate_object.valid?
          assert_not_empty duplicate_object.errors[attribute]
        end
      end
    end

    # Examples
    # validates_length_of :name
    # validates_length_of :description, 'text'
    # validates_length_of(%i[name code year])
    # validates_length_of(%i[description summary], 'text')
    def validates_length_of(attributes, type = 'string', object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take

      long_string = if type == 'string'
                      (0..256).map { ('a'..'z').to_a[rand(26)] }.join
                    elsif type == 'text'
                      (0..65_536).map { ('a'..'z').to_a[rand(26)] }.join
                    end

      [attributes].compact.flatten.each do |attribute|
        test "#{attribute} can not be longer than character limits for #{object}" do
          object.send("#{attribute}=", long_string)
          assert_not object.valid?
          assert object.errors.details[attribute].map { |err| err[:error] }.include?(:too_long)
        end
      end
    end

    # Examples
    # validates_numericality_of :year
    def validates_numericality_of(attribute, object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take

      test "#{attribute} attribute of #{object} must be a number" do
        object.send("#{attribute}=", 'some string')
        assert_not object.valid?
        assert object.errors.details[attribute].map { |err| err[:error] }.include?(:not_a_number)
      end
    end

    # Examples
    # validates_numerical_range(:year, :greater_than_or_equal_to, 100)
    # validates_numerical_range(:year, :less_than_or_equal_to, 100)
    def validates_numerical_range(attribute, range_identifier, number, object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take

      case range_identifier
      when :greater_than, :less_than
        number = number
      when :greater_than_or_equal_to
        number -= 1     
      when :less_than_or_equal_to
        number += 1
      end
      test "#{attribute} attribute of #{object} must be #{range_identifier} #{number}" do
        object.send("#{attribute}=", number)
        assert_not object.valid?
        assert object.errors.details[attribute].map { |err| err[:error] }.include?(range_identifier)
      end
    end
  end
end
