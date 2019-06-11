# frozen_string_literal: true

require 'test_helper'

class LinkHelperTest < ActionView::TestCase
  include FontAwesome::Rails::IconHelper

  LINK = <<-HTML
    <a class="%{klass}" %{options} href="%{path}"><i class="%{icon}"></i> %{text}</a>
  HTML

  LINKS = {
    back:    {
      klass:   'btn btn-secondary btn-sm',
      options: '',
      icon:    'fa fa-arrow-left',
      path:    '/path',
      text:    I18n.t('action_group.back')
    },
    destroy: {
      klass:   'btn btn-outline-danger btn-sm',
      options: "data-confirm='#{I18n.t('are_you_sure')}' rel='nofollow' data-method='delete'",
      icon:    'fa fa-trash',
      path:    '/path',
      text:    I18n.t('action_group.destroy')
    },
    edit:    {
      klass:   'btn btn-outline-success btn-sm',
      options: '',
      icon:    'fa fa-pencil',
      path:    '/path',
      text:    I18n.t('action_group.edit')
    },
    file:    {
      klass:   'btn btn-secondary btn-sm',
      options: '',
      icon:    'fa fa-file-word-o',
      path:    '/path',
      text:    I18n.t('action_group.file')
    },
    new:     {
      klass:   'btn btn-outline-primary btn-sm',
      options: 'id="add-button"',
      icon:    'fa fa-plus',
      path:    '/path',
      text:    I18n.t('action_group.add')
    },
    show:    {
      klass:   'btn btn-outline-info btn-sm',
      options: '',
      icon:    'fa fa-eye',
      path:    '/path',
      text:    I18n.t('action_group.show')
    },
    update:  {
      klass:   'btn btn-outline-info btn-sm',
      options: '',
      icon:    'fa fa-pencil-square-o',
      path:    '/path',
      text:    I18n.t('action_group.update')
    }
  }.freeze

  LINKS.each do |key, options|
    test "link_to_#{key} method" do
      link = format(LINK, options).squish.tr("'", '"')
      assert_equal send("link_to_#{key}", options[:path]), link
      assert_equal send("link_to_#{key}", options[:text], options[:path]), link
    end
  end

  test 'link_to_actions method' do
    course = Course.last

    links = {
      show:    link_to_show(course_path(course)),
      edit:    link_to_edit(edit_course_path(course)),
      destroy: link_to_destroy(course_path(course))
    }

    assert_equal link_to_actions(course), links.values.join(' ')
    assert_equal link_to_actions(course, except: :show), links.values_at(:edit, :destroy).join(' ')
    assert_equal link_to_actions(course, except: %i[show edit]), links.values_at(:destroy).join(' ')
    assert_equal link_to_actions(course, except: %i[edit destroy],
                                         show:   {
                                           text: 'Show', options: { class: 'btn btn-primary' }
                                         }),
                 link_to_show('Show', course_path(course), class: 'btn btn-primary')
  end
end
