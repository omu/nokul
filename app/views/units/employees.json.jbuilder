# frozen_string_literal: true

json.array!(@employees) do |employee|
  json.id employee.id
  json.full_name full_name(employee)
end
