# frozen_string_literal: true

require 'test_helper'

class KpsAddressJobTest < ActiveJob::TestCase
  test 'can enqueue Kps::AddressSaveJob' do
    assert_enqueued_jobs 0
    Kps::AddressSaveJob.perform_later(users(:serhat))
    assert_enqueued_jobs 1
  end

  test 'can initialize KPS queries as Kps::AddressSaveJob for given user and address' do
    client = Minitest::Mock.new
    def client.sorgula
      true
    end

    Services::Kps::Omu::Adres.stub :new, client do
      assert Kps::AddressSaveJob.perform_later({}) # dummy hash
    end
  end

  test 'can perform enqueued jobs for Kps::AddressSaveJob' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    assert_performed_jobs 0
    perform_enqueued_jobs do
      Kps::AddressSaveJob.perform_later(users(:serhat))
    end
    assert_performed_jobs 1
  end

  test 'KPS:Address jobs runs in the high priority queue' do
    assert_equal Kps::AddressSaveJob.new.queue_name, 'high'
  end
end
