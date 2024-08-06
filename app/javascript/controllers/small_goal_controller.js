import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="small-goal"
export default class extends Controller {

  connect() {
    console.log("読み取りOK");
  }

  test() {
    console.log("クリックしました");
  }

}
