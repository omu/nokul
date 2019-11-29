# frozen_string_literal: true

module ContactLinkHelper
  def social_media_links(user)
    safe_join(
      [
        link(user, icon: 'linkedin-square', method: :linkedin, url_prefix: 'https://linkedin.com/in/'),
        link(user, icon: 'skype', method: :skype, url_prefix: 'skype:'),
        link(user, icon: 'twitter-square', method: :twitter, url_prefix: 'https://twitter.com/')
      ].compact,
      tag.br
    )
  end

  def contact_links(user)
    safe_join(
      [
        link(user, icon: 'envelope', method: :email, url_prefix: 'mailto:'),
        link(user, icon: 'phone', method: :mobile_phone, url_prefix: 'tel:')
      ].compact,
      tag.br
    )
  end

  private

  def link(user, icon:, method:, url_prefix: '')
    text = user.public_send(method)
    return if text.blank?

    link_to(
      fa_icon(icon, class: 'header-icon', text: text),
      "#{url_prefix}#{text}",
      style: 'color: inherit;'
    )
  end
end
