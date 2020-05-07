# frozen_string_literal: true

require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:john)
    @student = students(:serhat)
    @academic_term = academic_terms(:fall_2018_2019)
  end

  test 'should get edit' do
    get edit_student_path(@student)
    assert_response :success
    assert_select '.card-header strong', t('students.edit.form_title')
  end

  test 'should update student' do
    patch student_path(@student), params: {
      student: {
        scholarship_type_id: scholarship_types(:kkk).id,
        history_attributes:  {
          entrance_type_id:     student_entrance_types(:osys).id,
          registration_date:    '2018-09-12 08:00:00',
          registration_term_id: @academic_term.id,
          other_studentship:    true,
          preparatory_class:    1
        }
      }
    }

    @student.reload

    assert_equal @student.scholarship_type_name, 'Kara Kuvvetleri Komutanlığı'
    assert_equal @student.entrance_type.name, 'ÖSYS'
    assert_equal @student.registration_date, '2018-09-12 08:00:00'.in_time_zone
    assert_equal @student.registration_term, @academic_term
    assert_equal @student.preparatory_class, 1
    assert @student.other_studentship
    assert_redirected_to user_path(@student.user)
    assert_equal translate('students.update.success'), flash[:notice]
  end
end
