# frozen_string_literal: true

json.array!(@units) do |unit|
  json.id unit.id
  json.text unit.name
  json.children(unit.children) do |child|
    json.id child.id
    json.text child.name
    json.children(unit.children) do |c|
      json.id c.id
      json.text c.name
    end
  end
end
