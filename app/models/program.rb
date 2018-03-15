class Program < ApplicationRecord
  # concerns
  include UnitStatus
  include InstructionType

  # relations
  belongs_to :unit

  # validations
  validates :name, :yoksis_id, :status, :type, :instruction_type,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true
  validates :name,
            uniqueness: { scope: %i[unit_id status] }

  # callbacks
  before_validation do
    self.name = name.capitalize_all
  end

  # STI helpers
  def self.types
    %w[
      UndergraduateProgram MasterProgram DoctoralProgram InterdisciplinaryMasterProgram
      InterdisciplinaryDoctoralProgram ProficiencyInArtProgram
    ]
  end

  scope :undergraduate_programs, -> { where(type: 'UndergraduateProgram') }
  scope :master_programs, -> { where(type: 'MasterProgram') }
  scope :doctoral_programs, -> { where(type: 'DoctoralProgram') }
  scope :interdisciplinary_master_programs, -> { where(type: 'InterdisciplinaryMasterProgram') }
  scope :interdisciplinary_doctoral_programs, -> { where(type: 'InterdisciplinaryDoctoralProgram') }
  scope :proficiency_in_art_programs, -> { where(type: 'ProficiencyInArtProgram') }
end
