# frozen_string_literal: true

class AddLanguageIdToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :language, foreign_key: true
  end
end
