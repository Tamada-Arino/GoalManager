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
        <tr>
          <th>小目標</th>
          <td>
            <input type="text" name="goal[small_goals_attributes][${this.index}][title]" />
            <input type="checkbox" name="goal[small_goals_attributes][${this.index}][achievable]" />
            <label for="goal_small_goals_attributes_${this.index}_achievable">達成済み</label>
          </td>
        </tr>
      </div>
    `;
    this.formsTarget.insertAdjacentHTML('beforeend', html);
    this.index++;
  }
}
