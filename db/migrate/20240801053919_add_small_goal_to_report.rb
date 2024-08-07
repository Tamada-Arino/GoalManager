class AddSmallGoalToReport < ActiveRecord::Migration[7.1]
  def change
    add_reference :reports, :small_goal, null: true, foreign_key: true
  end
end
