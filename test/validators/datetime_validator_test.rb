# frozen_string_literal: true

require 'test_helper'

class DatetimeValidatorTest < ActiveSupport::TestCase
  class DummyModel
    include ActiveModel::Validations

    attr_accessor :started_at, :finished_at

    def created_at
      Time.current - 15.minutes
    end
  end

  setup do
    @instance     = DummyModel.new
    @current_time = Time.current
  end

  test 'eql validation' do
    @instance.singleton_class.validates :started_at, datetime: { eql: @current_time }
    @instance.started_at = @current_time - 10.minutes

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time

    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'after validation' do
    @instance.singleton_class.validates :started_at, datetime: { after: @current_time }
    @instance.started_at = @current_time

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time + 15.minutes

    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'after_or_eql validation' do
    @instance.singleton_class.validates :started_at, datetime: { after_or_eql: @current_time }
    @instance.started_at = @current_time - 1.second

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time + 15.minutes
    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]

    @instance.started_at = @current_time
    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'before validation' do
    @instance.singleton_class.validates :started_at, datetime: { before: @current_time }
    @instance.started_at = @current_time

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time - 15.minutes

    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'before_or_eql validation' do
    @instance.singleton_class.validates :started_at, datetime: { before_or_eql: @current_time }
    @instance.started_at = @current_time + 1.second

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time - 15.minutes
    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]

    @instance.started_at = @current_time
    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'validation control value should be proc type' do
    @instance.singleton_class.validates :started_at, datetime: {
      before: ->(item) { item.finished_at - 15.minutes }
    }

    @instance.started_at  = @current_time
    @instance.finished_at = @current_time + 15.minutes

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time - 1.second
    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'validation control value should be method name' do
    @instance.singleton_class.validates :started_at, datetime: { before: :created_at }

    @instance.started_at = @current_time + 1.minute

    assert_not @instance.valid?
    assert_not_empty @instance.errors[:started_at]

    @instance.started_at = @current_time - 30.minutes
    assert       @instance.valid?
    assert_empty @instance.errors[:started_at]
  end

  test 'Set specific error message for each control' do
    @instance.singleton_class.validates :started_at, datetime: {
      after:          @current_time,
      after_message:  'test message for after',
      before:         @current_time - 2.seconds,
      before_message: 'test message for before'
    }

    @instance.started_at = @current_time - 1.second

    assert_not       @instance.valid?
    assert_not_empty @instance.errors[:started_at]
    assert_equal(['test message for after', 'test message for before'], @instance.errors.messages[:started_at])
  end
end
