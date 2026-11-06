import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["progressBar"]

  connect() {
    window.addEventListener("scroll", this.updateProgress.bind(this))
  }

  disconnect() {
    window.removeEventListener("scroll", this.updateProgress.bind(this))
  }

  updateProgress() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop
    const docHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight
    const progress = (scrollTop / docHeight) * 100
    this.progressBarTarget.style.width = `${progress}%`
  }
}
