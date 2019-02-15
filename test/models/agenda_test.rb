# frozen_string_literal: true

require 'test_helper'

class AgendaTest < ActiveSupport::TestCase
  include AssociationTestModule
  include EnumerationTestModule
  include ValidationTestModule

  # relations
  belongs_to :agenda_type
  belongs_to :unit
  has_many :meeting_agendas
  has_many :meetings

  # validations: presence
  validates_presence_of :description
  validates_presence_of :status

  # validations: length
  validates_length_of :description, 'text'

  # enums
  has_enum({ recent: 0, decided: 1, delayed: 2 }, 'status')

  # scopes
  test 'active scope returns recent and delayed agendas' do
    assert_equal Agenda.active.count, Agenda.recent.count + Agenda.delayed.count
    assert_not_includes Agenda.active, agendas(:three)
  end
end
