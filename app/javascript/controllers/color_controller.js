import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="color"
export default class extends Controller {
  static targets = ["radioButton"]

  changeColorValue(event) {
    this.radioButtonTarget.value = event.target.value
  }
}