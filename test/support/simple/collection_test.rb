# frozen_string_literal: true

require 'test_helper'

# rubocop:disable Metrics/ClassLength
class CollectionTest < ActiveSupport::TestCase
  class Unit
    class_attribute :units, default: []

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

  class Units < Simple::Collection
    def list_by_unit_type_id(unit_type_id)
      select { |unit| unit.unit_type_id == unit_type_id }
    end
  end

  test 'basic mechanism should automagically work' do
    units = Units.from_hashes [
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

  class Departments < Simple::Collection
    collection.collects = Unit

    def list_by_unit_type_id(unit_type_id)
      select { |unit| unit.unit_type_id == unit_type_id }
    end
  end

  test 'can specify aggregated item class explicitly' do
    units = Departments.from_hashes [
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

  class Foo < Simple::Collection
    collection.used = true
  end

  test 'can specify class level collection parameters' do
    assert_equal true, Foo.collection.used
  end

  class Bar
    include Simple::Container.of %i[x y z]
  end

  class Bars < Simple::Collection
    collection.used = true
  end

  test 'can specify instance level parameters' do
    bars = Bars.from_hashes [
      { x: 3,  y: 5,  z: 8  },
      { x: 13, y: 19, z: 42 }
    ]

    bars.property.ok = 'ok'

    assert_equal 'ok', bars.property.ok
  end

  test 'can specify instance level parameters at construction' do
    bars = Bars.new_with_properties [{ x: 3,  y: 5,  z: 8  },
                                     { x: 13, y: 19, z: 42 }], ok: 'ok'

    bars.property.ok = 'ok'

    assert_equal 'ok', bars.property.ok
  end

  test 'can read items from yaml blob' do
    units = Units.from_yaml <<~YAML
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
    units = Units.from_yaml <<~YAML
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

    assert_equal expected, Units.to_yaml(units)
  end

  class Patologic < Simple::Collection; end

  test 'should raise exception for patological cases' do
    exception = assert_raises(Simple::Collection::Error) { Patologic.new('foo') }
    assert_equal 'Construction argument must be an Array', exception.message

    exception = assert_raises(Simple::Collection::Error) { Patologic.from_hashes [{ var: 'foo' }] }
    assert_equal "Couldn't determine collection item class", exception.message

    exception = assert_raises(Simple::Collection::Error) { Patologic.from_hashes [{ var: 'foo' }, 'bar'] }
    assert_equal 'All collection items must be hash', exception.message
  end
end
# rubocop:enable Metrics/ClassLength
