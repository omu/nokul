# frozen_string_literal: true

json.array!(@units) do |unit|
  json.id unit.id
  json.text unit.name
  json.children(unit.children) do |unit|
    json.id unit.id
    json.text unit.name
    json.children(unit.children) do |unit|
      json.id unit.id
      json.text unit.name
    end
  end
end
