/* eslint-disable no-undef */
import { Controller } from 'stimulus'
import { fetchContent } from './fetch_content'

export default class extends Controller {
  static targets = ['content', 'loadingMessage', 'autoRefresh']

  connect() {
    this.load()
    if (this.data.has('refreshInterval') && this.hasautoRefreshTarget) {
      this.startRefreshing()
    }
  }

  disconnect() {
    this.stopRefreshing()
  }

  load() {
    fetchContent({
      url: this.url,
      targetElement: this.contentTarget,
      loadingElement: this.loadingMessageTarget
    })
    // fetch(this.url)
    //   .then(response => {
    //     if (!response.ok) {
    //       throw Error(response.statusText);
    //     }
    //     return response.text()
    //   })
    //   .then(html => {
    //     $(this.contentTarget).html(html)
    //     this.loadingMessageTarget.classList.add('d-none')
    //   })
    //   .catch((error) => {
    //     $(this.contentTarget).html("Hata Oluştu")
    //     this.loadingMessageTarget.classList.add('d-none')
    //   });
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.load()
    }, this.data.get('refreshInterval'))
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }

  autoRefreshStart() {
    if (this.autoRefreshTarget.checked) return this.startRefreshing()

    this.stopRefreshing()
  }

  reset() {
    // this.contentTarget.innerHTML = ''
    this.loadingMessageTarget.classList.remove('d-none')
  }

  refresh(event) {
    event.preventDefault()
    this.reset()
    this.load()
  }

  get url() {
    return this.data.get('url')
  }
}
