# frozen_string_literal: true

require 'test_helper'

class SudoTest < ActiveSupport::TestCase
  setup do
    @sudo = Patron::Sudo
  end

  test 'timeout defined' do
    assert_respond_to @sudo, :timeout
  end

  test 'enabled defined' do
    assert_respond_to @sudo, :enabled
  end

  test 'required_now? method' do
    @sudo.enabled = true

    assert @sudo.required?(Time.current - 16.minutes)
    assert @sudo.required?(Time.current - 6.minutes, timeout: 5.minutes)
    assert_not @sudo.required?(Time.current - 14.minutes)
    assert_not @sudo.required?(Time.current - 4.minutes, timeout: 5.minutes)

    @sudo.enabled = false
    assert_not @sudo.required?(Time.current - 16.minutes)
  end

  test 'enabled? method' do
    @sudo.enabled = true
    assert @sudo.enabled?

    @sudo.enabled = false
    assert_not @sudo.enabled?
  end

  test 'timed_out? method' do
    @sudo.timeout = 15.minutes

    assert @sudo.timed_out?(Time.current - 15.minutes)
    assert @sudo.timed_out?(Time.current - 16.minutes)
    assert @sudo.timed_out?(Time.current - 6.minutes, timeout: 5.minutes)

    assert_not @sudo.timed_out?(Time.current - 14.minutes)
    assert_not @sudo.timed_out?(Time.current - 4.minutes, timeout: 5.minutes)
  end
end
