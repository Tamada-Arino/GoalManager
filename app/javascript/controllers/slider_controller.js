import { Controller } from "@hotwired/stimulus"
import { CellStyles } from "./cell_styles"

export default class extends Controller {
  static targets = ["value", "colorSample"]

  applyStyles = CellStyles.applyStyles
  darkenColorValue = CellStyles.darkenColorValue

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
    const opacity = this.buildOpacity(statusNumber)

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

  buildOpacity(statusNumber) {
    switch (statusNumber) {
      case 1:
        return 0.3
      case 2:
        return 0.6
      default:
        return 1
    }
  }
}
