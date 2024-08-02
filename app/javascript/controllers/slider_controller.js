import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value"]

  changeValue() {
    this.valueTarget.textContent = document.querySelector("#slider").value
  }
}
