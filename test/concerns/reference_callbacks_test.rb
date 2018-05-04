# frozen_string_literal: true

require 'test_helper'

module ReferenceCallbacksTest
  extend ActiveSupport::Concern

  included do
    test 'callbacks must titlecase the name for reference objects' do
      @object.update!(name: 'ışık ılık süt iç')
      assert_equal @object.name, 'Işık Ilık Süt Iç'
    end
  end
end
