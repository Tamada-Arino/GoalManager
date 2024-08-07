class CreateSmallGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :small_goals do |t|
      t.references :goal, null: false, foreign_key: true
      t.string :title, null: false
      t.boolean :achievable, default: false

      t.timestamps
    end
  end
end
