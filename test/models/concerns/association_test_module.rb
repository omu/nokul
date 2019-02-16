# frozen_string_literal: true

module AssociationTestModule
  extend ActiveSupport::Concern

  class_methods do
    # Examples
    # has_many :addresses
    # has_many :addresses, :identities, :student_numbers
    # has_many :addresses, object: Address.first
    # belongs_to :user
    # belongs_to :user :unit
    # has_one :identity

    %i[has_many has_one belongs_to].each do |method|
      define_method(method) do |*associations, object: nil|
        associations.each do |association|
          test "#{object} #{method} #{association}" do
            # rubocop:disable Lint/AmbiguousBlockAssociation
            object ||= class_name.delete_suffix('Test').constantize
            assert object.reflect_on_all_associations(method).select { |relation| relation.name.eql?(associations) }
            # rubocop:enable Lint/AmbiguousBlockAssociation
          end
        end
      end
    end
  end
end
