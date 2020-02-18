# frozen_string_literal: true

json.results do
  json.array!(@units) do |unit|
    json.id unit.id
    json.text unit.name
    json.yoksis_id unit.yoksis_id
    json.children(unit.children) do |unit|
      json.id unit.id
      json.text unit.name
      json.ancestry unit.ancestry
      json.children(unit.children) do |unit|
        json.id unit.id
        json.text unit.name
        json.ancestry unit.ancestry
      end
    end
  end
end
