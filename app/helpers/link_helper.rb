# frozen_string_literal: true

module LinkHelper
  LINKS = {
    back: {
      icon: 'arrow-left',
      text: I18n.t('action_group.back'),
      options: {
        class: 'btn btn-secondary btn-sm'
      }
    },
    destroy: {
      icon: 'trash',
      text: I18n.t('action_group.destroy'),
      options: {
        class: 'btn btn-outline-danger btn-sm',
        method: :delete,
        data: { confirm: I18n.t('are_you_sure') }
      }
    },
    edit: {
      icon: 'pencil',
      text: I18n.t('action_group.edit'),
      options: {
        class: 'btn btn-outline-success btn-sm'
      }
    },
    new: {
      icon: 'plus',
      text: I18n.t('action_group.add'),
      options: {
        class: 'btn btn-outline-primary btn-sm',
        id: 'add-button'
      }
    },
    show: {
      icon: 'eye',
      text: I18n.t('action_group.show'),
      options: {
        class: 'btn btn-outline-info btn-sm'
      }
    },
    update: {
      icon: 'pencil-square-o',
      text: I18n.t('action_group.update'),
      options: {
        class: 'btn btn-outline-info btn-sm'
      }
    },
    file: {
      icon: 'file-word-o',
      text: I18n.t('action_group.file'),
      options: {
        class: 'btn btn-secondary btn-sm'
      }
    }
  }.freeze

  LINKS.each do |action, configuration|
    define_method("link_to_#{action}") do |*args|
      link_builder(args, configuration)
    end
  end

  # Usage:
  # link_to_actions(@cities,
  #                 scope: :admin,
  #                 except: :show,
  #                 edit: { text: 'Edit Text' })
  def link_to_actions(path, options = {})
    actions = (%i[show edit destroy] - [*options[:except]].map(&:to_sym)).inquiry
    path = [*options[:scope], *path]
    links = []
    links << link_to_show(options.dig(:show, :text), [*path])        if actions.show?
    links << link_to_edit(options.dig(:edit, :text), [:edit, *path]) if actions.edit?
    links << link_to_destroy(options.dig(:destroy, :text), [*path])  if actions.destroy?
    safe_join(links, ' ')
  end

  private

  def link_builder(args, configuration)
    text, path = split_args_for_link_to(args)
    link_to(
      fa_icon(configuration[:icon], text: text || configuration[:text]),
      path,
      configuration.fetch(:options, {})
    )
  end

  def split_args_for_link_to(args)
    args.length == 1 ? [nil, *args] : args
  end
end
