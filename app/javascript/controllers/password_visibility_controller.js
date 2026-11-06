import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "visible", "hidden", "button"]

  toggle() {
    if (!this.hasInputTarget) return

    const isVisible = this.inputTarget.type === "text"
    const nextType = isVisible ? "password" : "text"
    this.inputTarget.type = nextType

    if (this.hasVisibleTarget) {
      this.visibleTarget.classList.toggle("hidden", nextType === "text")
    }

    if (this.hasHiddenTarget) {
      this.hiddenTarget.classList.toggle("hidden", nextType === "password")
    }

    if (this.hasButtonTarget) {
      const label = nextType === "text" ? "Hide password" : "Show password"
      this.buttonTarget.setAttribute("aria-label", label)
      this.buttonTarget.setAttribute("title", label)
      this.buttonTarget.setAttribute("aria-pressed", nextType === "text" ? "true" : "false")
    }
  }
}
