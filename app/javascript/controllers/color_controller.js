import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="color"
export default class extends Controller {
  static targets = ["radioButton", "colorPicker"]

  changeColorValue() {
    this.radioButtonTarget.value = this.colorPickerTarget.value
  }
}
