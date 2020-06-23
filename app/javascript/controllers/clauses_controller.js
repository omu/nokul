import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['content', 'modal']

  detail () {
    fetch(document.location + '/clause?identifier=' + event.target.parentElement.dataset.identifier)
      .then(response => {
        if (response.ok) return response.text()

        throw Error(response.statusText)
      })
      .then(html => {
        this.contentTarget.innerHTML = html
        coreui.Modal(this.modalTarget).show()
      })
      .catch(() => {
        this.contentTarget.innerHTML = "Hata"
      })

      $(this.modalTarget).modal({ show: true })
  }
}
