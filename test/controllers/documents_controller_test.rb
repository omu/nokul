# frozen_string_literal: true

require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:john)
    @document = documents(:health_report)
  end

  test 'should get index' do
    get documents_path
    assert_response :success
    assert_select '#add-button', t('documents.index.new_document_link')
  end

  test 'should get show' do
    get document_path(@document)
    assert_response :success
  end

  test 'should get new' do
    get new_document_path
    assert_response :success
  end

  test 'should create document' do
    assert_difference('Document.count') do
      post documents_path params: {
        document: { name: 'Document' }
      }
    end

    document = Document.last

    assert_equal 'Document', document.name
    assert_redirected_to document_path(document)
    assert_equal t('documents.create.success'), flash[:notice]
  end

  test 'should get edit' do
    get edit_document_path(@document)
    assert_response :success
    assert_select '.card-header strong', t('documents.edit.form_title')
  end

  test 'should update document' do
    document = Document.last
    patch document_path(document), params: {
      document: { name: 'Document' }
    }

    document.reload

    assert_equal 'Document', document.name
    assert_redirected_to document_path(document)
    assert_equal translate('documents.update.success'), flash[:notice]
  end

  test 'should destroy document' do
    assert_difference('Document.count', -1) do
      delete document_path(Document.last)
    end

    assert_redirected_to documents_path
    assert_equal translate('documents.destroy.success'), flash[:notice]
  end
end
