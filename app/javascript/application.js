// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "bootstrap/dist/css/bootstrap.min.css"



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