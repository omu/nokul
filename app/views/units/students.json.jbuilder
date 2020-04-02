# frozen_string_literal: true

json.array!(@students) do |student|
  json.id student.id
  json.full_name full_name(student.user.identities.formal.first)
end
