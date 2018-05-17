# frozen_string_literal: true

require 'test_helper'

class ApplicationJobTest < ActiveJob::TestCase
  # field tests
  test 'ActiveJob is up and running' do
    assert ApplicationJob.new.job_id
  end
end
