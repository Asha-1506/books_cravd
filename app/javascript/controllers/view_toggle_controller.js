import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["table", "grid", "button"]

  connect() {
    console.log("View toggle controller connected")
    
    // Get view mode from URL parameter
    const urlParams = new URLSearchParams(window.location.search)
    this.currentView = urlParams.get('view_mode') || 'grid'
    
    // Show the appropriate view
    if (this.currentView === 'list') {
      this.showTableView()
    } else {
      this.showGridView()
    }
  }

  toggle(event) {
    event.preventDefault()
    console.log("Toggle clicked, current view:", this.currentView)
    
    // Toggle between table and grid views
    if (this.currentView === "list") {
      this.currentView = "grid"
      this.showGridView()
      this.updateURL('grid')
    } else {
      this.currentView = "list"
      this.showTableView()
      this.updateURL('list')
    }
  }

  showTableView() {
    console.log("Showing table view")
    this.tableTarget.style.display = "block"
    this.gridTarget.style.display = "none"
    this.buttonTarget.innerHTML = '<i class="bi bi-grid-fill"></i> Grid View'
  }

  showGridView() {
    console.log("Showing grid view")
    this.tableTarget.style.display = "none"
    this.gridTarget.style.display = "block"
    this.buttonTarget.innerHTML = '<i class="bi bi-list-ul"></i> List View'
  }

  updateURL(viewMode) {
    const url = new URL(window.location)
    url.searchParams.set('view_mode', viewMode)
    window.history.pushState({}, '', url)
  }
}
