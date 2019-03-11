# frozen_string_literal: true

every 1.day, at: '2:00 am' do
  rake 'nokul:archive_prospective_students'
end
