# frozen_string_literal: true

require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:john)
    @student = students(:serhat)
  end

  test 'should get edit' do
    get edit_student_path(@student)
    assert_response :success
    assert_select '.card-header strong', t('students.edit.form_title')
  end

  test 'should update student' do
    patch student_path(@student), params: {
      student: {
        scholarship_type_id: scholarship_types(:kkk).id
      }
    }

    @student.reload

    assert_equal 'Kara Kuvvetleri Komutanlığı', @student.scholarship_type_name
    assert_redirected_to user_path(@student.user)
    assert_equal translate('students.update.success'), flash[:notice]
  end
end
