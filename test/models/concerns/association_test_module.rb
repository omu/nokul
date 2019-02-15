# frozen_string_literal: true

module AssociationTestModule
  extend ActiveSupport::Concern

  class_methods do
    # rubocop:disable Naming/PredicateName

    # Examples
      # has_many :addresses
      # has_many(%i[addresses identities student_numbers])
      # belongs_to :user
      # belongs_to(%i[user unit])
      # has_one :identity
      # has_many(:addresses, addresses(:formal))
    def has_many(associations, object = nil)
      object ||= to_s.delete_suffix('Test').constantize.take

      [associations].compact.flatten.each do |association|
        test "#{object} has_many #{association}" do
          assert object.send(association)
        end
      end
    end
    # rubocop:enable Naming/PredicateName

    alias_method :has_one, :has_many
    alias_method :belongs_to, :has_many
  end
end
