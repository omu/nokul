/* eslint-disable no-undef */
export function fetchContent ({ url, targetElement, loadingElement }) {
  const ERROR_MESSAGE = `
    <div class="alert alert-danger text-center">
      <p class="h4">
        <i class="fa fa-exclamation-triangle"></i>
        İşlem sırasında bir hata oluştu! Lütfen tekrardan deneyiniz.
      </p>
    </div>
  `

  fetch(url)
    .then(response => {
      if (response.ok) return response.text()

      throw Error(response.statusText)
    })
    .then(html => {
      $(targetElement).html(html)
      loadingElement.classList.add('d-none')
    })
    .catch(() => {
      $(targetElement).html(ERROR_MESSAGE)
      loadingElement.classList.add('d-none')
    })
}
