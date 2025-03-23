import "@hotwired/turbo-rails"
import "@popperjs/core"
import "bootstrap"
import "./controllers"

// Turboを明示的に開始
import * as Turbo from "@hotwired/turbo-rails"
Turbo.start()

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