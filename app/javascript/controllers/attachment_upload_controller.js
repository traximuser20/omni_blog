import { Controller } from "@hotwired/stimulus"

// Handles the post attachment dropzone: drag & drop, file list preview and
// keeps the underlying file input in sync.
export default class extends Controller {
  static targets = ["input", "dropzone", "list", "summary"]

  update() {
    const files = Array.from(this.inputTarget.files || [])

    this.listTarget.replaceChildren(...files.map((file) => this.buildRow(file)))
    this.summaryTarget.textContent =
      files.length === 0 ? "No files selected" : `${files.length} file${files.length === 1 ? "" : "s"} selected`
  }

  dragover(event) {
    event.preventDefault()
    this.highlight(true)
  }

  dragleave(event) {
    event.preventDefault()
    this.highlight(false)
  }

  drop(event) {
    event.preventDefault()
    this.highlight(false)

    if (!event.dataTransfer.files.length) return

    const transfer = new DataTransfer()
    Array.from(this.inputTarget.files || []).forEach((file) => transfer.items.add(file))
    Array.from(event.dataTransfer.files).forEach((file) => transfer.items.add(file))
    this.inputTarget.files = transfer.files

    this.update()
  }

  highlight(on) {
    this.dropzoneTarget.classList.toggle("border-orange-400", on)
    this.dropzoneTarget.classList.toggle("bg-orange-50/60", on)
  }

  buildRow(file) {
    const row = document.createElement("li")
    row.className =
      "flex items-center gap-3 rounded-xl border border-stone-200 bg-white px-3 py-2.5 shadow-sm"

    const name = document.createElement("span")
    name.className = "min-w-0 flex-1 truncate text-sm font-medium text-stone-700"
    name.textContent = file.name

    const size = document.createElement("span")
    size.className = "font-mono text-[10px] uppercase tracking-[0.16em] text-stone-400"
    size.textContent = this.humanSize(file.size)

    row.append(name, size)
    return row
  }

  humanSize(bytes) {
    if (bytes < 1024) return `${bytes} B`

    const units = ["KB", "MB", "GB"]
    let value = bytes / 1024
    let unit = units.shift()

    while (value >= 1024 && units.length > 0) {
      value /= 1024
      unit = units.shift()
    }

    return `${value.toFixed(1)} ${unit}`
  }
}
