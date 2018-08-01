# frozen_string_literal: true

require 'test_helper'

class KpsIdentityJobTest < ActiveJob::TestCase
  test 'can enqueue KpsIdentitySaveJob' do
    assert_enqueued_jobs 0
    KpsIdentitySaveJob.perform_later(users(:serhat))
    assert_enqueued_jobs 1
  end

  test 'can initialize KPS queries as KpsIdentitySaveJob for given user and identities' do
    client = Minitest::Mock.new
    def client.sorgula
      true
    end

    Services::Kps::Omu::Kimlik.stub :new, client do
      assert KpsIdentitySaveJob.perform_later({}) # dummy hash
    end
  end

  test 'can perform enqueued jobs for KpsIdentitySaveJob' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    assert_performed_jobs 0
    perform_enqueued_jobs do
      KpsIdentitySaveJob.perform_later(users(:serhat))
    end
    assert_performed_jobs 1
  end
end
