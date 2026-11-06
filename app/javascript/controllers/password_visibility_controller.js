import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "visible", "hidden"]

  toggle() {
    const isPassword = this.inputTarget.type === "password"
    this.inputTarget.type = isPassword ? "text" : "password"

    this.visibleTarget.classList.toggle("hidden", !isPassword)
    this.hiddenTarget.classList.toggle("hidden", isPassword)
  }
}
