class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :goal, null: false, foreign_key: true
      t.text :content
      t.date :target_date
      t.integer :progress_value

      t.timestamps
    end

    add_index :reports, [:goal_id, :target_date], unique: true
  end
end
