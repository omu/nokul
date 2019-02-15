# frozen_string_literal: true

module AssociationTestModule
  extend ActiveSupport::Concern

  class_methods do
    def has_many(object = nil, associations)
      object ||= self.to_s.delete_suffix('Test')

      associations.each do |association|
        test "#{object} has_many #{association}" do
          assert object.constantize.take.send(association)
        end
      end
    end

    alias_method :has_one, :has_many
    alias_method :belongs_to, :has_many
  end
end
