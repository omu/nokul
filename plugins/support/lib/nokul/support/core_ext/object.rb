# frozen_string_literal: true

class Object
  def to_yaml_pretty
    yaml = to_yaml line_width: -1
    yaml.gsub!(/\s+$/, '')
    yaml.gsub!("\n-", "\n\n-")
    yaml.gsub!(/^( +)-/, '\\1  -')
    yaml << "\n"
  end
end
