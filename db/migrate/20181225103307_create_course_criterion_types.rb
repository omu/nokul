class CreateCourseCriterionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_criterion_types do |t|
      t.string :name
      t.string :identifier
    end

    add_presence_constraint :course_criterion_types, :name
    add_presence_constraint :course_criterion_types, :identifier

    add_length_constraint :course_criterion_types, :name, less_than_or_equal_to: 255
    add_length_constraint :course_criterion_types, :identifier, less_than_or_equal_to: 255

    add_unique_constraint :course_criterion_types, :name
    add_unique_constraint :course_criterion_types, :identifier
  end
end
