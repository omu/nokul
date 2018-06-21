# frozen_string_literal: true

module EnumI18nHelper
  # enum_options_for_select(Course, :status)
  def enum_options_for_select(klass, enum)
    klass.send(enum.to_s.pluralize).map do |key, _|
      [translate(klass, enum, key), key]
    end
  end

  # enum_t(course, :status)
  def enum_t(object, enum)
    translate(object.class, enum, object.send(enum))
  end

  private

  def translate(klass, enum, value)
    I18n.t(
      value,
      scope: [:activerecord, :enums, klass.model_name.i18n_key, enum.to_s.pluralize]
    )
  end
end
