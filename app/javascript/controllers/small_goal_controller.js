import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="small-goal"
export default class extends Controller {
  static targets = ["forms", "button"]

  connect() {
    this.index = 0;
    this.updateButtonState();
  }

  insertHtml() {
    const html = `
      <div class="control small_goals mx-3 mb-3">
        <label>小目標</label>
        <br>
        <div class="is-flex align_items">
          <input type="text" class="input is-small" name="goal[small_goals_attributes][${this.index}][title]">
          <button type="button" class="button is-danger is-light is-small" data-action="click->small-goal#removeHtml">
            削除
          </button>
        </div>
      </div>
    `;
    this.formsTarget.insertAdjacentHTML('beforeend', html);
    this.index++;
    this.updateButtonState();
  }

  removeHtml(event) {
    event.currentTarget.closest("div").remove();
    this.updateButtonState();
  }

  updateButtonState() {
    const smallGoalCount = this.formsTarget.querySelectorAll(".small_goals").length;
    if (smallGoalCount >= 3) {
      this.buttonTarget.disabled = true;
    } else {
      this.buttonTarget.disabled = false;
    }
  }
}
