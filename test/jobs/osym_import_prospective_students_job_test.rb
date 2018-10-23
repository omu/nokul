# frozen_string_literal: true

require 'test_helper'

class OsymImportProspectiveStudentsJobTest < ActiveJob::TestCase
  test 'can enqueue Osym::ImportProspectiveStudentsJob' do
    assert_enqueued_jobs 0
    Osym::ImportProspectiveStudentsJob.perform_later('test/fixtures/files/prospective_students.csv.enc')
    assert_enqueued_jobs 1
  end

  test 'can perform enqueued jobs for Osym::ImportProspectiveStudentsJob' do
    assert_performed_jobs 0

    assert_difference('ProspectiveStudent.count', 3) do
      perform_enqueued_jobs do
        Osym::ImportProspectiveStudentsJob.perform_later('test/fixtures/files/prospective_students.csv.enc')
      end

      assert_performed_jobs 1
    end
  end

  test 'Osym::ImportProspectiveStudentsJob runs in the high priority queue' do
    assert_equal Osym::ImportProspectiveStudentsJob.new.queue_name, 'high'
  end
end
