import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="color"
export default class extends Controller {
  static targets = ["radioButton"]

  changeColorValue(event) {
    this.radioButtonTarget.value = event.target.value
  }

  changeSample(event) {
    const badStatus = document.querySelector("#sample_1")
    const sosoStatus = document.querySelector("#sample_2")
    const nomalStatus =  document.querySelector("#sample_3")
    const goodStatus = document.querySelector("#sample_4")

    const baseColor = event.target.value

    console.log(baseColor);

    badStatus.style.color = baseColor
    badStatus.style.opacity = 0.3

    sosoStatus.style.color = baseColor
    sosoStatus.style.opacity = 0.6

    nomalStatus.style.color = baseColor

    console.log(this.darkenColorValue(baseColor))
    goodStatus.style.color = this.darkenColorValue(baseColor)
  }

  darkenColorValue(hex) {
    let r = parseInt(hex.slice(1, 3), 16)
    let g = parseInt(hex.slice(3, 5), 16)
    let b = parseInt(hex.slice(5, 7), 16)

    r = Math.max(0, r - 50)
    g = Math.max(0, g - 50)
    b = Math.max(0, b - 50)

    return `rgb(${r}, ${g}, ${b})`
  }
}
