# frozen_string_literal: true

require 'test_helper'

class RakeUtilsTest < ActiveSupport::TestCase
  class FakeModel
    class_attribute :collections, default: []

    def self.create(item)
      collections << item
    end
  end

  test 'entities should be created from yaml' do
    created_titles = Support.create_entities_from_yaml(
      'RakeUtilsTest::FakeModel', filename: 'titles', basepath: Rails.root.join('test', 'fixtures')
    )
    assert_equal created_titles.size, Title.count
  end
end
