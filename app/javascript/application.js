import "@hotwired/turbo-rails"
import "@popperjs/core"
import "bootstrap"
import "controllers"

// Bootstrap のタブ機能を有効化
document.addEventListener("DOMContentLoaded", function() {
  let triggerTabList = [].slice.call(document.querySelectorAll('a[data-bs-toggle="tab"]'))
  triggerTabList.forEach(function (triggerEl) {
    let tabTrigger = new bootstrap.Tab(triggerEl)

    triggerEl.addEventListener("click", function (event) {
      event.preventDefault()
      tabTrigger.show()
    })
  })
});