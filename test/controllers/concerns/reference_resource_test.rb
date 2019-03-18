# frozen_string_literal: true

require_relative 'yoksis_resource_test'

module ReferenceResourceTest
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      include YoksisResourceTest

      setup do
        @target_path = 'reference'
      end
    end
  end
end
