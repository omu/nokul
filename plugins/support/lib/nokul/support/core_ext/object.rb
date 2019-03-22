# frozen_string_literal: true

class Object
  def to_yaml_pretty
    yaml = to_yaml line_width: -1
    yaml.gsub!(/\s+$/, '')
    yaml.gsub!("\n-", "\n\n-")
    yaml.gsub!(/^( +)-/, '\\1  -')
    yaml << "\n"
  end

  module Type_ # rubocop:disable Naming/ClassAndModuleCamelCase
    module_function

    def sanitize_arguments(*args)
      args.each do |arg|
        raise ArgumentError, 'Type information must be a class' unless arg.is_a? Class
      end
    end

    def type_error(object, type)
      "#{type} expected where found: #{object.class}" unless object.is_a? type
    end

    def must_be_array(object, type)
      sanitize_arguments(sample_type = type.first)

      object.each do |element|
        if (error = type_error(element, sample_type))
          return error
        end
      end

      nil
    end

    def must_be_hash(object, type)
      sanitize_arguments(*(key_type, value_type = type.first))

      object.each do |key, value|
        if (error = type_error(key, key_type))
          return error
        end

        if (error = type_error(value, value_type))
          return error
        end
      end

      nil
    end

    def must_be_range(object, type)
      sanitize_arguments(starting_type = type.first)
      sanitize_arguments(ending_type = type.first)

      if (error = type_error(object.first, starting_type))
        return error
      end

      type_error(object.last, ending_type)
    end

    def must_be_other(object, type)
      type_error(object, type)
    end

    def must_be(object, type)
      case type
      when Array then must_be_array(object, type)
      when Hash  then must_be_hash(object, type)
      when Range then must_be_range(object, type)
      else            must_be_other(object, type)
      end
    end

    def must_be_any_of(object, *args)
      return object if args.empty?
      return object unless (first = (types = args.dup).shift)
      return object unless (error = must_be(object, first))

      raise(TypeError, error) if types.empty?

      return object if types.any? { |type| must_be(object, type).nil? }

      raise TypeError, "One of #{args} expected where found: #{object.class}"
    end
  end

  private_constant :Type__

  def must_be_any_of!(*type_specifications)
    Type_.must_be_any_of(self, *type_specifications)
  end
end
