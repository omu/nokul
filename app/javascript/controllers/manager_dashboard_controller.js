/* eslint-disable no-undef */
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['content', 'loadingMessage' ]

  load (event) {
    this.reset()
    fetch(event.target.dataset.contentUrl)
      .then(response => response.text())
      .then(html => {
        $(this.contentTarget).html(html)
        this.loadingMessageTarget.classList.add('d-none')
      })
  }


  reset () {
    this.loadingMessageTarget.classList.remove('d-none')
  }
}
