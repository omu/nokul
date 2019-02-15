# frozen_string_literal: true

require 'test_helper'

module ReferenceTestModule
  extend ActiveSupport::Concern

  # callbacks
  included do
    test 'callbacks must titlecase the name for reference objects' do
      @object.update(name: 'ışık ılık süt iç')
      assert_equal @object.name, 'Işık Ilık Süt İç'
    end
  end
end
