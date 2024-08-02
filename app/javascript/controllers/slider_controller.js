import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slider", "value"]

  connect() {
    this.sliderTarget.addEventListener('input', () => this.changeValue())
  }

  changeValue() {
    this.valueTarget.textContent = this.sliderTarget.value
  }
}
