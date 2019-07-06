# frozen_string_literal: true

require 'test_helper'

class KpsIdentityJobTest < ActiveJob::TestCase
  test 'can enqueue Kps::IdentitySaveJob' do
    assert_enqueued_jobs 0
    Kps::IdentitySaveJob.perform_later(users(:serhat))
    assert_enqueued_jobs 1
  end

  test 'can initialize KPS queries as Kps::IdentitySaveJob for given user and identities' do
    client = Minitest::Mock.new

    Xokul::Kps::Identity.stub :new, client do
      assert Kps::IdentitySaveJob.perform_later({}) # dummy hash
    end
  end

  test 'can perform enqueued jobs for Kps::IdentitySaveJob' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    assert_no_performed_jobs
    assert_performed_jobs 1, only: Kps::IdentitySaveJob do
      Kps::IdentitySaveJob.perform_later(users(:serhat))
    end
  end

  test 'KPS::Identity jobs runs in the high priority queue' do
    assert_equal Kps::IdentitySaveJob.new.queue_name, 'high'
  end
end
