# frozen_string_literal: true

require 'test_helper'

class KpsAddressJobTest < ActiveJob::TestCase
  test 'can enqueue KpsAddressSaveJob' do
    assert_enqueued_jobs 0
    KpsAddressSaveJob.perform_later(users(:serhat))
    assert_enqueued_jobs 1
  end

  test 'can initialize KPS queries as KpsAddressSaveJob for given user and address' do
    client = Minitest::Mock.new
    def client.sorgula
      true
    end

    Services::Kps::Omu::Adres.stub :new, client do
      assert KpsAddressSaveJob.perform_later({}) # dummy hash
    end
  end

  test 'can perform enqueued jobs for KpsAddressSaveJob' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    assert_performed_jobs 0
    perform_enqueued_jobs do
      KpsAddressSaveJob.perform_later(users(:serhat))
    end
    assert_performed_jobs 1
  end
end
