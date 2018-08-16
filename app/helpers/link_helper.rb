# frozen_string_literal: true

module LinkHelper
  # Dynamic link builder for show, edit and destroy
  #
  # @example
  #   link_to_actions(@unit, course)
  #   link_to_actions(@unit, course, only: %i[show])
  def link_to_actions(*objects, only: %i[show edit destroy])
    only = only.inquiry
    links = []
    links << link_to_show(objects) if only.show?
    links << link_to_edit([:edit, *objects]) if only.edit?
    links << link_to_destroy(objects) if only.destroy?

    tag.div safe_join(links), class: 'btn-group', role: 'group'
  end

  def link_to_back(path = nil, text = t('action_group.back'))
    link_to(
      fa_icon('arrow-left', text: text),
      path,
      class: 'btn btn-secondary btn-sm'
    )
  end

  def link_to_destroy(path = nil, text = t('action_group.destroy'))
    link_to(
      fa_icon('trash', text: text),
      path,
      method: :delete,
      data: { confirm: t('are_you_sure') },
      class: 'btn btn-outline-danger btn-sm'
    )
  end

  def link_to_edit(path = nil, text = t('action_group.edit'))
    link_to(
      fa_icon('pencil', text: text),
      path,
      class: 'btn btn-outline-success btn-sm'
    )
  end

  def link_to_new(path = nil, text = t('action_group.add'))
    link_to(
      fa_icon('plus', text: text),
      path,
      class: 'btn btn-outline-primary btn-sm',
      id: 'add-button'
    )
  end

  def link_to_show(path = nil, text = t('action_group.show'))
    link_to(
      fa_icon('eye', text: text),
      path,
      class: 'btn btn-outline-info btn-sm'
    )
  end

  def link_to_update(path = nil, text = t('action_group.update'))
    link_to(
      fa_icon('pencil-square-o', text: text),
      path,
      class: 'btn btn-outline-info btn-sm'
    )
  end
end
