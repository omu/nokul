# frozen_string_literal: true

require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  setup do
    @curriculum = curriculums(:one)
  end

  # relations
  test 'curriculum can communicate with unit' do
    assert @curriculum.unit
  end

  test 'curriculum can communicate with programs' do
    assert @curriculum.programs
  end

  # validations: presence
  %i[
    name
    number_of_semesters
    status
    unit
  ].each do |property|
    test "presence validations for #{property} of a curriculum" do
      @curriculum.send("#{property}=", nil)
      assert_not @curriculum.valid?
      assert_not_empty @curriculum.errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a curriculum' do
    fake = @curriculum.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]

    fake.unit_id = units(:cbu).id
    assert fake.valid?
    assert_empty fake.errors[:name]
  end

  # validations: numericality
  test 'numericality validations for number_of_semesters of a curriculum' do
    @curriculum.number_of_semesters = 0
    assert_not @curriculum.valid?
    assert_not_empty @curriculum.errors[:number_of_semesters]
  end

  # enums
  {
    status: { passive: 0, active: 1 }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = Curriculum.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end
end
