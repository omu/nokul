# frozen_string_literal: true

class UnitCodesPresentRule < Ruling::Rule
  synopsis 'Unit codes must be present'
  subject :unit

  rule 'codes must be present' do
    spot detail if unit.code.blank?
  end

  private

  FORMATTER = proc { |**param| format('%<label>24s: %<item>s', **param) }

  def detail
    [
      { label: 'Offending unit', item: unit.name }
    ].map { |args| FORMATTER.call(**args) }.join "\n"
  end
end
