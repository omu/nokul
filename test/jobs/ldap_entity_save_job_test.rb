# frozen_string_literal: true

require 'test_helper'

class LdapEntitySaveJobTest < ActiveJob::TestCase
  test 'can enqueue LDAP::EntitySaveJob' do
    assert_enqueued_jobs 0
    LDAP::EntitySaveJob.perform_later(users(:serhat))
    assert_enqueued_jobs 1
  end

  test 'can perform enqueued jobs for LDAP::EntitySaveJob' do
    assert_no_performed_jobs

    assert_performed_jobs 2, only: [LDAP::EntitySaveJob, LDAP::SyncJob] do
      LDAP::EntitySaveJob.perform_later(users(:serhat))
    end
  end

  test 'LDAP::EntitySaveJob runs in the high priority queue' do
    assert_equal LDAP::EntitySaveJob.new.queue_name, 'high'
  end
end
