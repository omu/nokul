# frozen_string_literal: true

require 'test_helper'

class LinkHelperTest < ActionView::TestCase
  include FontAwesome::Rails::IconHelper

  test 'link_to_back method' do
    link = <<-HTML.squish
      <a class="btn btn-secondary btn-sm" href="#"><i class="fa fa-arrow-left"></i> Back</a>
    HTML
    assert_equal link_to_back('Back', '#'), link
  end

  test 'link_to_destroy method' do
    link = <<-HTML.squish
      <a class="btn btn-outline-danger btn-sm"
         data-confirm="#{t('are_you_sure')}"
         rel="nofollow" data-method="delete" href="#"><i class="fa fa-trash"></i> Test Destroy</a>
    HTML
    assert_equal link_to_destroy('Test Destroy', '#'), link
  end

  test 'link_to_edit method' do
    link = <<-HTML.squish
      <a class="btn btn-outline-success btn-sm"
         href="#"><i class="fa fa-pencil"></i> Test Edit</a>
    HTML
    assert_equal link_to_edit('Test Edit', '#'), link
  end

  test 'link_to_new method' do
    link = <<-HTML.squish
      <a class="btn btn-outline-primary btn-sm" id="add-button"
         href="#"><i class="fa fa-plus"></i> Test New</a>
    HTML
    assert_equal link_to_new('Test New', '#'), link
  end

  test 'link_to_show' do
    link = <<-HTML.squish
      <a class="btn btn-outline-info btn-sm"
         href="#"><i class="fa fa-eye"></i> Test Show</a>
    HTML
    assert_equal link_to_show('Test Show', '#'), link
  end

  test '#link_to_update' do
    link = <<-HTML.squish
      <a class="btn btn-outline-info btn-sm"
        href="#"><i class="fa fa-pencil-square-o"></i> Test Update</a>
    HTML
    assert_equal link_to_update('Test Update', '#'), link
  end
end
