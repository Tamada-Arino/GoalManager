import { Controller } from "@hotwired/stimulus"
import { CellStyles } from "./cell_styles"

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

    const cells = this.sampleCells();

    CellStyles.applyStyles(cells.bad, baseColor, 0.3)
    CellStyles.applyStyles(cells.soso, baseColor, 0.6)
    CellStyles.applyStyles(cells.nomal, baseColor)
    CellStyles.applyStyles(cells.good,  CellStyles.darkenColorValue(baseColor))
  }

  sampleCells() {
    return {
      bad: document.querySelector("#sample_1"),
      soso: document.querySelector("#sample_2"),
      nomal: document.querySelector("#sample_3"),
      good: document.querySelector("#sample_4")
    }
  }
}
