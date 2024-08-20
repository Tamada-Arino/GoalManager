import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "colorSample"]

  connect() {
    this.changeSample(this.valueTarget.value)
  }

  changeValue(event) {
    const progressValue = event.target.value
    this.valueTarget.textContent = progressValue
    this.changeSample(progressValue)
  }

  changeSample(progressValue) {
    const statusNumber = this.buildStatusNumber(progressValue)
    let color = this.element.dataset.goalColor
    let opacity

    switch (statusNumber) {
      case 1:
        opacity = 0.3
        break
      case 2:
        opacity = 0.6
        break
      case 4:
        color = this.darkenColorValue(color)
        break
      default:
        opacity = 1
    }

    this.applyStyles(this.colorSampleTarget, color, opacity)
  }

  buildStatusNumber(progressValue) {
    if (progressValue > 0) {
      return Math.floor((progressValue - 1) / 25) + 1
    } else {
      return 1
    }
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
