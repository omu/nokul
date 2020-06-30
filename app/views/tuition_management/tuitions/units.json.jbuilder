# frozen_string_literal: true

json.array!(@units) do |unit|
  json.id unit.id
  json.text unit.name
  json.children(unit.subprograms.active.or(unit.subprograms.partially_passive)) do |program|
    json.id program.id
    json.text program.name
  end
end
