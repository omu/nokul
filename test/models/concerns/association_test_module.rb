# frozen_string_literal: true

module AssociationTestModule
  extend ActiveSupport::Concern

  class_methods do
    # rubocop:disable Naming/PredicateName
    def has_many(associations, object = nil)
      object ||= to_s.delete_suffix('Test')

      [associations].compact.flatten.each do |association|
        test "#{object} has_many #{association}" do
          assert object.constantize.take.send(association)
        end
      end
    end
    # rubocop:enable Naming/PredicateName

    alias_method :has_one, :has_many
    alias_method :belongs_to, :has_many
  end
end
