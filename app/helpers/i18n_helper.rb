# frozen_string_literal: true

module I18nHelper
  # enum_options_for_select(Course, :status)
  def enum_options_for_select(klass, enum)
    klass.send(enum.to_s.pluralize).map do |key, _|
      [translate(klass, enum, key), key]
    end
  end

  # enum_t(course, :status)
  def enum_t(object, enum)
    translate(object, enum, object.send(enum))
  end

  # options_for_select_for_collection([:add, :new])
  def collection_options_for_select(collection)
    collection.each_with_object([]) do |key, result|
      result << [I18n.t(key, scope: :collection), key.to_s]
    end
  end

  private

  def translate(klass, enum, value)
    return '' unless value.nil?
    I18n.t(
      value,
      scope: [:activerecord, :enums, klass.model_name.i18n_key, enum.to_s.pluralize]
    )
  end
end
