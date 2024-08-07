import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="small-goal"
export default class extends Controller {
  static targets = ["forms"]

  connect() {
    this.index = 0;
  }

  insertHtml() {
    const html = `
      <div class="form small_goals">
        <label>小目標</label>
        <br>
        <input type="text" name="goal[small_goals_attributes][${this.index}][title]" />
        <input type="checkbox" name="goal[small_goals_attributes][${this.index}][achievable]" />
        <label for="goal_small_goals_attributes_${this.index}_achievable">達成済み</label>
        <button type="button" data-action="click->small-goal#removeHtml">削除</button>
      </div>
    `;
    this.formsTarget.insertAdjacentHTML('beforeend', html);
    this.index++;
  }

  removeHtml(event) {
    event.currentTarget.closest("div").remove();
  }
}
