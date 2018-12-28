# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @prospective_student = ProspectiveStudentDecorator.new(
      prospective_students(:serhat)
    )
  end

  test 'academic_term method' do
    assert_equal @prospective_student.academic_term, AcademicTerm.active.last
  end

  test 'registration_documents method' do
    registration_documents = RegistrationDocument.where(
      unit_id: @prospective_student.unit_id,
      academic_term: @prospective_student.academic_term
    )
    assert_equal @prospective_student.registration_documents, registration_documents
  end

  test 'permanent_registrable? method' do
    assert_not @prospective_student.permanent_registrable?
  end

  test 'temporary_registrable? method' do
    assert_not @prospective_student.temporary_registrable?
  end

  test 'document_required? method' do
    assert_equal @prospective_student.registration_documents.present?,
                 @prospective_student.document_required?
  end
end
