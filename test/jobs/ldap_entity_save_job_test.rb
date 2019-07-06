# frozen_string_literal: true

require 'test_helper'

class LdapEntitySaveJobTest < ActiveJob::TestCase
  test 'can enqueue Ldap::EntitySaveJob' do
    assert_enqueued_jobs 0
    Ldap::EntitySaveJob.perform_later(users(:serhat))
    assert_enqueued_jobs 1
  end

  test 'can perform enqueued jobs for Ldap::EntitySaveJob' do
    assert_no_performed_jobs

    assert_performed_jobs 2, only: [Ldap::EntitySaveJob, Ldap::SyncJob] do
      Ldap::EntitySaveJob.perform_later(users(:serhat))
    end
  end

  test 'Ldap::EntitySaveJob runs in the high priority queue' do
    assert_equal Ldap::EntitySaveJob.new.queue_name, 'high'
  end
end
