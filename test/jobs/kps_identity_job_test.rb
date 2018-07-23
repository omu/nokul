# frozen_string_literal: true

require 'test_helper'

class KpsIdentityJobTest < ActiveJob::TestCase
  %w[
    KpsIdentitySaveJob
  ].each do |property|
    test "can enqueue #{property}" do
      assert_enqueued_jobs 0
      property.constantize.perform_later(identities(:serhat_formal))
      assert_enqueued_jobs 1
    end

    test "can initialize KPS queries as #{property} for given user and identities" do
      client = Minitest::Mock.new
      def client.sorgula
        true
      end

      Services::Kps::Omu::Kimlik.stub :new, client do
        assert property.constantize.perform_later({}) # dummy hash
      end
    end
  end

  %w[
    KpsIdentitySaveJob
  ].each do |property|
    test "can perform enqueued jobs for #{property}" do
      skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
      assert_performed_jobs 0
      args = users(:serhat)
      perform_enqueued_jobs do
        property.constantize.perform_later(args)
      end
      assert_performed_jobs 1
    end
  end
end
