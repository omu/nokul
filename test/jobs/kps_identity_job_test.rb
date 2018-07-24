# frozen_string_literal: true

require 'test_helper'

class KpsIdentityJobTest < ActiveJob::TestCase
  test 'can enqueue KpsIdentityJobTest' do
    assert_enqueued_jobs 0
    'KpsIdentitySaveJob'.constantize.perform_later(identities(:serhat_formal))
    assert_enqueued_jobs 1
  end

  test 'can initialize KPS queries as KpsIdentityJobTest for given user and identities' do
    client = Minitest::Mock.new
    def client.sorgula
      true
    end

    Services::Kps::Omu::Kimlik.stub :new, client do
      assert 'KpsIdentitySaveJob'.constantize.perform_later({}) # dummy hash
    end
  end

  test 'can perform enqueued jobs for KpsIdentityJobTest' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    assert_performed_jobs 0
    perform_enqueued_jobs do
      'KpsIdentitySaveJob'.constantize.perform_later(users(:serhat))
    end
    assert_performed_jobs 1
  end
end
