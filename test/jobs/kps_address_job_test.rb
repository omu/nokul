# frozen_string_literal: true

require 'test_helper'

class KpsAddressJobTest < ActiveJob::TestCase
  %w[
    KpsAddressCreateJob
    KpsAddressUpdateJob
  ].each do |property|
    test "can enqueue #{property}" do
      assert_enqueued_jobs 0
      property.constantize.perform_later(addresses(:formal))
      assert_enqueued_jobs 1
    end

    test "can initialize KPS queries as #{property} for given user and address" do
      client = Minitest::Mock.new
      def client.sorgula
        true
      end

      Services::Kps::Omu::Adres.stub :new, client do
        assert property.constantize.perform_later({}) # dummy hash
      end
    end
  end

  %w[
    KpsAddressCreateJob
    KpsAddressUpdateJob
  ].each do |property|
    test "can perform enqueued jobs for #{property}" do
      skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
      assert_performed_jobs 0
      args = if property.eql?('KpsAddressCreateJob')
               users(:serhat)
             else
               addresses(:formal)
             end
      perform_enqueued_jobs do
        property.constantize.perform_later(args)
      end
      assert_performed_jobs 1
    end
  end
end
