import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "colorSample"]

  connect() {
    this.changeSample(this.valueTarget.textContent)
  }

  changeValue(event) {
    const progressValue = event.target.value
    this.valueTarget.textContent = progressValue
    this.changeSample(progressValue)
  }

  changeSample(progressValue) {
    const statusNumber = this.buildStatusNumber(progressValue)
    const defaultColor = this.element.dataset.goalColor
    const color = statusNumber === 4 ? this.darkenColorValue(defaultColor) : defaultColor
    let opacity

    switch (statusNumber) {
      case 1:
        opacity = 0.3
        break
      case 2:
        opacity = 0.6
        break
    }

    this.applyStyles(this.colorSampleTarget, color, opacity)
  }

  buildStatusNumber(progressValue) {
    const offsetNumber = 1
    const thresholdValue = 25

    if (progressValue > 0) {
      return Math.floor((progressValue - offsetNumber) / thresholdValue) + offsetNumber
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
