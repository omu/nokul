# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    class CollectionTest < ActiveSupport::TestCase
      class Unit
        class_attribute :units, default: []

        include Structure.of %i[
          name
          abbreviation
          yoksis_id
          unit_type_id
        ]

        def faculty?
          unit_type_id == 'Fakülte'
        end
      end

      class Units < Collection
        def list_by_unit_type_id(unit_type_id)
          select { |unit| unit.unit_type_id == unit_type_id }
        end
      end

      test 'basic mechanism should automagically work' do
        units = Units.create [
          {
            'name' => 'Mühendislik Fakültesi',
            'abbreviation' => 'MÜHENDİSLİK',
            'yoksis_id' => '122183',
            'unit_type_id' => 'Fakülte'
          },
          {
            'name' => 'Bilgisayar Mühendisliği Bölümü',
            'abbreviation' => 'BİLGİSAYAR',
            'yoksis_id' => '122184',
            'unit_type_id' => 'Bölüm'
          }
        ]

        assert_equal Unit, units.first.class
        assert_equal 2, units.size
        assert_equal 1, units.list_by_unit_type_id('Fakülte').size
      end

      class Departments < Collection
        collection.collects = Unit

        def list_by_unit_type_id(unit_type_id)
          select { |unit| unit.unit_type_id == unit_type_id }
        end
      end

      test 'can specify aggregated item class explicitly' do
        units = Departments.create [
          {
            'name' => 'Mühendislik Fakültesi',
            'abbreviation' => 'MÜHENDİSLİK',
            'yoksis_id' => '122183',
            'unit_type_id' => 'Fakülte'
          },
          {
            'name' => 'Bilgisayar Mühendisliği Bölümü',
            'abbreviation' => 'BİLGİSAYAR',
            'yoksis_id' => '122184',
            'unit_type_id' => 'Bölüm'
          }
        ]

        assert_equal Unit, units.first.class
        assert_equal 1, units.list_by_unit_type_id('Fakülte').size
      end

      test 'can read items from yaml blob' do
        units = Units.create_from_yaml <<~YAML
          - name: Mühendislik Fakültesi
            abbreviation: MÜHENDİSLİK
            yoksis_id: 122183
            unit_type_id: Fakülte

          - name: Bilgisayar Mühendisliği Bölümü
            abbreviation: BİLGİSAYAR
            yoksis_id: 122184
            unit_type_id: Bölüm
        YAML

        assert_equal 1, units.list_by_unit_type_id('Fakülte').size
      end

      test 'can write items as yaml blob' do
        units = Units.create_from_yaml <<~YAML
          ---

          - name: Mühendislik Fakültesi
            abbreviation: MÜHENDİSLİK
            yoksis_id: 122183
            unit_type_id: Fakülte

          - name: Bilgisayar Mühendisliği Bölümü
            abbreviation: BİLGİSAYAR
            yoksis_id: 122184
            unit_type_id: Bölüm
        YAML
        units.second.unit_type_id = 'Fakülte'

        assert_equal 2, units.list_by_unit_type_id('Fakülte').size

        expected = <<~YAML
          ---

          - name: Mühendislik Fakültesi
            abbreviation: MÜHENDİSLİK
            yoksis_id: 122183
            unit_type_id: Fakülte

          - name: Bilgisayar Mühendisliği Bölümü
            abbreviation: BİLGİSAYAR
            yoksis_id: 122184
            unit_type_id: Fakülte
        YAML

        assert_equal expected, Units.to_yaml_pretty(units)
      end

      class Patologic < Collection; end

      test 'should raise exception for patological cases' do
        exception = assert_raises(Collection::Error) { Patologic.new('foo') }
        assert_equal 'Construction argument must be an Array where found String', exception.message

        exception = assert_raises(Collection::Error) { Patologic.create [{ var: 'foo' }] }
        assert_equal "Couldn't determine collection item class", exception.message

        exception = assert_raises(Collection::Error) { Patologic.create [{ var: 'foo' }, 'bar'] }
        assert_equal 'All collection items must be hash', exception.message
      end
    end
  end
end
