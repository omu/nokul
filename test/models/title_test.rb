# frozen_string_literal: true

require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  # relations
  test 'a title has_many employees' do
    assert titles(:research_assistant).employees
  end

  # validations: presence
  %i[
    name
    code
    branch
  ].each do |property|
    # validations: presence
    test "presence validations for #{property} of a title" do
      titles(:research_assistant).send("#{property}=", nil)
      assert_not titles(:research_assistant).valid?
      assert_not_empty titles(:research_assistant).errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for name and code fields of a title' do
    fake = titles(:research_assistant).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end

  # other validations
  test 'name, code and branch can not be longer than 255 characters' do
    fake = titles(:professor).dup
    random_long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    fake.name = random_long_string
    fake.code = random_long_string
    fake.branch = random_long_string
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
    assert fake.errors.details[:code].map { |err| err[:error] }.include?(:too_long)
    assert fake.errors.details[:branch].map { |err| err[:error] }.include?(:too_long)
  end
end
