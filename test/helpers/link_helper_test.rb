# frozen_string_literal: true

require 'test_helper'

class LinkHelperTest < ActionView::TestCase
  include FontAwesome::Rails::IconHelper

  test '#link_to_back' do
    link = <<-HTML.squish
      <a class="btn btn-dark btn-sm mb-1"
         href="#"><i class="fa fa-arrow-left"></i> Back</a>
    HTML
    assert_equal link_to_back('#', text: 'Back'), link
  end

  test '#link_to_destroy' do
    link = <<-HTML.squish
      <a data-confirm="#{t('are_you_sure')}"
         class="btn btn-outline-danger btn-sm mb-1"
         rel="nofollow" data-method="delete" href="#"><i class="fa fa-trash"></i> Test Destroy</a>
    HTML
    assert_equal link_to_destroy('#', text: 'Test Destroy'), link
  end

  test '#link_to_edit' do
    link = <<-HTML.squish
      <a class="btn btn-outline-success btn-sm mb-1"
         href="#"><i class="fa fa-pencil"></i> Test Edit</a>
    HTML
    assert_equal link_to_edit('#', text: 'Test Edit'), link
  end

  test '#link_to_new' do
    link = <<-HTML.squish
      <a class="btn btn-outline-primary btn-sm mb-1"
         href="#"><i class="fa fa-plus"></i> Test New</a>
    HTML
    assert_equal link_to_new('#', text: 'Test New'), link
  end

  test '#link_to_show' do
    link = <<-HTML.squish
      <a class="btn btn-outline-info btn-sm mb-1"
         href="#"><i class="fa fa-eye"></i> Test Show</a>
    HTML
    assert_equal link_to_show('#', text: 'Test Show'), link
  end

  test '#link_to_update' do
    link = <<-HTML.squish
      <a class="btn btn-outline-info btn-sm mb-1"
        href="#"><i class="fa fa-pencil-square-o"></i> Test Update</a>
    HTML
    assert_equal link_to_update('#', text: 'Test Update'), link
  end
end
