import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value"]

  changeValue(event) {
    this.valueTarget.textContent = event.target.value
  }
}
