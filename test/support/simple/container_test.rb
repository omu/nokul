# frozen_string_literal: true

require 'test_helper'

class ContainerTest < ActiveSupport::TestCase
  class Unit
    include Simple::Container.of %i[
      name
      abbreviation
      yoksis_id
      unit_type_id
    ]

    def faculty?
      unit_type_id == 'Fakülte'
    end
  end

  unit = Unit.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                  yoksis_id: '122183', unit_type_id: 'Fakülte')

  test 'basic mechanism should just work' do
    assert_equal 'Mühendislik Fakültesi', unit.name
    assert_equal true, unit.faculty?
  end

  class Unit
    class_attribute :units, default: []

    def after_initialize
      self.class.units << name
    end
  end

  test 'class level attributes should work' do
    assert_equal 0, Unit.units.size

    unit = Unit.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                    yoksis_id: '122183', unit_type_id: 'Fakülte')

    assert_equal 1, Unit.units.size
  end
end
