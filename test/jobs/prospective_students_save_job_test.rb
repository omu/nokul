# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentsSaveJobTest < ActiveJob::TestCase
  test 'Yoksis::ProspectiveStudentsSaveJob runs in the high priority queue' do
    assert_equal('high', Yoksis::ProspectiveStudentsSaveJob.new.queue_name)
  end
end
