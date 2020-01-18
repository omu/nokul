/* eslint-disable no-undef */
import { Controller } from 'stimulus'
import { fetchContent } from './fetch_content'

export default class extends Controller {
  static targets = ['content', 'loadingMessage']

  load (event) {
    this.showLoading()

    fetchContent({
      url: event.target.dataset.contentUrl,
      targetElement: this.contentTarget,
      loadingElement: this.loadingMessageTarget
    })
  }

  showLoading () {
    this.loadingMessageTarget.classList.remove('d-none')
  }
}
