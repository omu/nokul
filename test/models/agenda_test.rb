# frozen_string_literal: true

require 'test_helper'

class AgendaTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :agenda_type
  belongs_to :unit
  has_many :meetings
  has_many :meeting_agendas

  # validations: presence
  validates_presence_of :description
  validates_presence_of :status

  # validations: length
  validates_length_of :description, 'text'

  # scopes
  test 'active scope returns recent and delayed agendas' do
    assert_equal Agenda.active.count, Agenda.recent.count + Agenda.delayed.count
    assert_not_includes Agenda.active, agendas(:three)
  end
end
