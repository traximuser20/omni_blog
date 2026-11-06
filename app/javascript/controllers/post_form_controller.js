import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "titleCount", "content", "wordCount"]

  connect() {
    this.update()
  }

  update() {
    if (this.hasTitleTarget) {
      this.titleCountTarget.textContent = `${this.titleTarget.value.length} / 120`
    }
    if (this.hasContentTarget) {
      const text = this.contentTarget.value.trim()
      const words = text === "" ? 0 : text.split(/\s+/).length
      const mins = Math.max(1, Math.ceil(words / 200))
      this.wordCountTarget.textContent = `${words} words · ${mins} min read`
    }
  }
}
