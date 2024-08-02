import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slider", "value"]

  changeValue() {
    this.valueTarget.textContent = this.sliderTarget.value
  }
}
