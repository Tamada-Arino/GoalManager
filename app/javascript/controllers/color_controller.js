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
      this.changeSample(event);
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
    this.applyStyles(cells.soso, baseColor, 0.3)
    this.applyStyles(cells.nomal, baseColor)
    this.applyStyles(cells.good, this.darkenColorValue(baseColor))
  }

  applyStyles(cell, color, opacity) {
    cell.style.backgroundColor = color
    if (opacity !== undefined) {
      cell.style.opacity = opacity
    }
  }

  darkenColorValue(hex) {
    const darkenValue = 65

    let r = parseInt(hex.slice(1, 3), 16)
    let g = parseInt(hex.slice(3, 5), 16)
    let b = parseInt(hex.slice(5, 7), 16)

    r = Math.max(0, r - darkenValue)
    g = Math.max(0, g - darkenValue)
    b = Math.max(0, b - darkenValue)

    return `rgb(${r}, ${g}, ${b})`
  }
}
