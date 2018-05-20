# frozen_string_literal: true

require 'test_helper'

class ApplicationJobTest < ActiveJob::TestCase
  # treasure: http://api.rubyonrails.org/classes/ActiveJob/TestHelper.html

  test 'ActiveJob is up and running' do
    assert ApplicationJob.new.job_id
  end

  test 'ensure that queue adapter is TestAdapter for tests' do
    assert_instance_of ActiveJob::QueueAdapters::TestAdapter, ApplicationJob.queue_adapter
  end
end
