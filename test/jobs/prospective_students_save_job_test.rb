# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentsSaveJobTest < ActiveJob::TestCase
  test 'Yoksis::ProspectiveStudentsSaveJob runs in the high priority queue' do
    assert_equal Yoksis::ProspectiveStudentsSaveJob.new.queue_name, 'high'
  end
end
