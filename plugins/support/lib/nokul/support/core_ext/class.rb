# frozen_string_literal: true

class Class
  # Extracted from Rails code base
  def convey_attributes_to_child(child, *attributes)
    attributes.each do |attribute|
      dup = send(attribute).dup
      value = case attribute
              when Hash  then dup.each { |k, v| dup[k] = v.dup }
              when Array then dup.each_with_index { |v, i| dup[i] = v.dup }
              else            dup
              end
      child.send "#{attribute}=", value
    end
  end

  def inherited_by_conveying_attributes(*attributes, &block)
    define_singleton_method :inherited do |child|
      convey_attributes_to_child(child, *attributes)
      super(child)
      block&.call(child)
    end
  end
end
