import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="color"
export default class extends Controller {
  static targets = ["customRadio", "customColor"]

  connect() {
    this.initializeColor()
  }

  changeColorValue(event) {
    this.customRadioTarget.value = event.target.value

    if (this.customRadioTarget.checked) {
      this.changeSample(event)
    }
  }

  initializeColor() {
    const baseColor = this.customColorTarget.value
    if (baseColor) {
      this.changeSample({ target: { value: baseColor } })
    }
  }

  changeSample(event) {
    const baseColor = event.target.value

    const cells = {
      bad: document.querySelector("#sample_1"),
      soso: document.querySelector("#sample_2"),
      nomal: document.querySelector("#sample_3"),
      good: document.querySelector("#sample_4")
    }

    this.applyStyles(cells.bad, baseColor, 0.3)
    this.applyStyles(cells.soso, baseColor, 0.6)
    this.applyStyles(cells.nomal, baseColor)
    this.applyStyles(cells.good, this.darkenColorValue(baseColor))
  }

  applyStyles(cell, color, opacity = 1) {
    cell.style.backgroundColor = color
    cell.style.opacity = opacity
  }

  darkenColorValue(hex) {
    const darkenValue = 65

    const rgb = [
      parseInt(hex.slice(1, 3), 16),
      parseInt(hex.slice(3, 5), 16),
      parseInt(hex.slice(5, 7), 16)
    ]

    const darkenedRgb = rgb.map(value => Math.max(0, value - darkenValue))

    return `rgb(${darkenedRgb.join(", ")})`
  }
}
