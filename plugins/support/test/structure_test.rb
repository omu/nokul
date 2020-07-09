# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    # rubocop:disable Metrics/ClassLength
    class StructureTest < ActiveSupport::TestCase
      Basic = Class.new do
        include Structure.of BASIC_PROPERTIES = %i[
          name
          abbreviation
          yoksis_id
          unit_type_id
        ].freeze

        def faculty?
          unit_type_id == 'Fakülte'
        end
      end

      test 'basic mechanism should just work' do
        unit = Basic.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                         yoksis_id: '122183', unit_type_id: 'Fakülte')

        assert_equal 'Mühendislik Fakültesi', unit.name
        assert(unit.faculty?)
      end

      test 'can get member list from class' do
        assert_empty Basic.members - BASIC_PROPERTIES
      end

      test 'can convert to a hash' do
        unit = Basic.new(name: 'Mühendislik Fakültesi', abbreviation: 'ABC',
                         yoksis_id: '122183', unit_type_id: 'Fakülte')

        assert_equal unit.to_h, name:         'Mühendislik Fakültesi',
                                abbreviation: 'ABC',
                                yoksis_id:    '122183',
                                unit_type_id: 'Fakülte'
      end

      test 'can convert to a hash without nil values by default' do
        unit = Basic.new(name: 'Mühendislik Fakültesi', abbreviation: nil,
                         yoksis_id: '122183', unit_type_id: 'Fakülte')

        assert_equal unit.to_h(omit_if_nil: %i[abbreviation]), name:         'Mühendislik Fakültesi',
                                                               yoksis_id:    '122183',
                                                               unit_type_id: 'Fakülte'
      end

      # rubocop:disable Performance/RedundantMerge
      test 'can merge with a hash' do
        unit = Basic.new(name: 'Mühendislik Fakültesi', abbreviation: 'ABC',
                         yoksis_id: '122183', unit_type_id: 'Fakülte')

        unit.merge!(name: 'Ziraat Fakültesi', yoksis_id: '123456')

        assert_equal unit.to_h, name:         'Ziraat Fakültesi',
                                abbreviation: 'ABC',
                                yoksis_id:    '123456',
                                unit_type_id: 'Fakülte'
      end

      test 'can merge with a structure object' do
        unit = Basic.new(name: 'Mühendislik Fakültesi', abbreviation: 'ABC',
                         yoksis_id: '122183', unit_type_id: 'Fakülte')

        other = Basic.new(name: 'Ziraat Fakültesi', yoksis_id: '123456')

        unit.merge!(other)

        assert_equal unit.to_h, name:         'Ziraat Fakültesi',
                                abbreviation: 'ABC',
                                yoksis_id:    '123456',
                                unit_type_id: 'Fakülte'
      end

      KeepProperties = Class.new do
        include Structure.of %i[
          name
          name_
          abbreviation
          yoksis_id
          unit_type_id
        ].freeze
      end

      test 'can merge with a hash by keeping some members' do
        unit = KeepProperties.new(name_: 'Mühendislik Fakültesi', abbreviation: 'ABC',
                                  yoksis_id: '122183', unit_type_id: 'Fakülte')

        unit.merge_keep!(name: 'Ziraat Fakültesi').to_h

        assert_equal unit.to_h, name:         'Mühendislik Fakültesi',
                                name_:        'Mühendislik Fakültesi',
                                abbreviation: 'ABC',
                                yoksis_id:    '122183',
                                unit_type_id: 'Fakülte'
      end

      test 'should not keep if keeping member is nil' do
        unit = KeepProperties.new(name: 'Mühendislik Fakültesi', abbreviation: 'ABC',
                                  yoksis_id: '122183', unit_type_id: 'Fakülte')

        unit.merge_keep!(name: 'Ziraat Fakültesi').to_h

        assert_equal unit.to_h, name:         'Ziraat Fakültesi',
                                abbreviation: 'ABC',
                                yoksis_id:    '122183',
                                unit_type_id: 'Fakülte'
      end
      # rubocop:enable Performance/RedundantMerge

      Pathologic = Class.new do
        include Structure.of! %i[
          name
          abbreviation
          yoksis_id
          unit_type_id
        ]
      end

      test 'can catch missing members' do
        assert_raise(ArgumentError) do
          _ = Pathologic.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                             yoksis_id: '122183', unit_type_id: 'Fakülte', missing: 'missing member')
        end
      end

      AfterInitializeHook = Class.new do
        class_attribute :units, default: []

        include Structure.of %i[
          name
          abbreviation
          yoksis_id
          unit_type_id
        ]

        def after_initialize(*)
          self.class.units << name
        end
      end

      test 'should support after initialization hook' do
        assert_equal 0, AfterInitializeHook.units.size

        _ = AfterInitializeHook.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                                    yoksis_id: '122183', unit_type_id: 'Fakülte')

        assert_equal 1, AfterInitializeHook.units.size
      end

      BaseModule = Module.new do
        include Structure.of %i[
          foo
          bar
        ]
      end

      SimpleMixedClass = Class.new do
        include BaseModule
      end

      test 'simple mixin should work' do
        unit = SimpleMixedClass.new foo: 3, bar: 5

        assert_equal [3, 5], [unit.foo, unit.bar]
      end

      OtherModule = Module.new do
        include BaseModule
      end

      FancyMixedClass = Class.new do
        include OtherModule
      end

      test 'fancy mixins should work' do
        unit = FancyMixedClass.new foo: 3, bar: 5

        assert_equal [3, 5], [unit.foo, unit.bar]
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
