import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['content', 'modal']

  detail (event) {
    window.fetch(this.url(event.target.parentElement.dataset.identifier))
      .then(response => {
        this.showModal()

        if (response.ok) return response.json()

        throw Error(response.statusText)
      })
      .then(data => {
        this.contentTarget.innerHTML = data.description || '-'
      })
      .catch(() => {
        this.contentTarget.innerHTML = 'Loading Error'
      })
  }

  showModal () {
    const modal = new window.coreui.Modal(this.modalTarget, {
      keyboard: false
    })
    modal.show()
  }

  url (identifier) {
    return [
      document.location.origin,
      document.location.pathname,
      '/clause?identifier=',
      identifier
    ].join('')
  }
}
