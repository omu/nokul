import { Controller } from 'stimulus'
import { fetchContent } from './fetch_content'

export default class extends Controller {
  static targets = ['content', 'loadingMessage', 'autoRefresh']

  connect () {
    this.load()
    if (this.data.has('refreshInterval') && this.hasautoRefreshTarget) {
      this.startRefreshing()
    }
  }

  disconnect () {
    this.stopRefreshing()
  }

  load () {
    fetchContent({
      url: this.url,
      targetElement: this.contentTarget,
      loadingElement: this.loadingMessageTarget
    })
  }

  startRefreshing () {
    this.refreshTimer = setInterval(() => {
      this.load()
    }, this.data.get('refreshInterval'))
  }

  stopRefreshing () {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }

  autoRefreshStart () {
    if (this.autoRefreshTarget.checked) return this.startRefreshing()

    this.stopRefreshing()
  }

  showLoading () {
    this.loadingMessageTarget.classList.remove('d-none')
  }

  refresh (event) {
    event.preventDefault()
    this.showLoading()
    this.load()
  }

  get url () {
    return this.data.get('url')
  }
}
