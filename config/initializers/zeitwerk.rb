# frozen_string_literal: true

class CustomInflector < Zeitwerk::Inflector
  def camelize(basename, _abspath)
    case basename
    when 'ldap' then 'LDAP'
    else
      super
    end
  end
end

Rails.autoloaders.each do |autoloader|
  autoloader.inflector = CustomInflector.new
end
