import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["progressBar"]

  connect() {
    this.boundUpdateProgress = this.updateProgress.bind(this)
    window.addEventListener("scroll", this.boundUpdateProgress)
  }

  disconnect() {
    if (this.boundUpdateProgress) {
      window.removeEventListener("scroll", this.boundUpdateProgress)
    }
  }

  updateProgress() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop
    const docHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight
    const progress = (scrollTop / docHeight) * 100
    this.progressBarTarget.style.width = `${progress}%`
  }
}
