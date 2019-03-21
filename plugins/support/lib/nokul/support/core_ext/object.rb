# frozen_string_literal: true

class Object
  def to_yaml_pretty
    yaml = to_yaml line_width: -1
    yaml.gsub!(/\s+$/, '')
    yaml.gsub!("\n-", "\n\n-")
    yaml.gsub!(/^( +)-/, '\\1  -')
    yaml << "\n"
  end

  module TypeCop
    module_function

    def sanitize_arguments(*args)
      args.each do |arg|
        raise ArgumentError, 'Type information must be a class' unless arg.is_a? Class
      end
    end

    def type_error(object, type)
      "#{type} expected where found: #{object.class}" unless object.is_a? type
    end

    def ensure_array(object, type)
      sanitize_arguments(sample_type = type.first)

      object.each do |element|
        if (error = type_error(element, sample_type))
          return error
        end
      end

      nil
    end

    def ensure_hash(object, type)
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

    def ensure_range(object, type)
      sanitize_arguments(starting_type = type.first)
      sanitize_arguments(ending_type = type.first)

      if (error = type_error(object.first, starting_type))
        return error
      end

      type_error(object.last, ending_type)
    end

    def ensure_scalar(object, type)
      type_error(object, type)
    end

    def ensure_one(object, type)
      case type
      when Array then ensure_array(object, type)
      when Hash  then ensure_hash(object, type)
      when Range then ensure_range(object, type)
      else            ensure_scalar(object, type)
      end
    end

    def ensure!(object, *args)
      return object if args.empty?
      return object unless (first = (types = args.dup).shift)
      return object unless (error = ensure_one(object, first))

      raise(TypeError, error) if types.empty?

      return object if types.any? { |type| ensure_one(object, type).nil? }

      raise TypeError, "One of #{args} expected where found: #{object.class}"
    end
  end

  private_constant :TypeCop

  def must_be_any_of!(*args)
    TypeCop.ensure!(self, *args)
  end
end
