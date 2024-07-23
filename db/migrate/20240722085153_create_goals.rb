class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.string :title
      t.date :start_date
      t.date :schedules_end_date
      t.date :end_date
      t.boolean :interrupted, default: false
      t.string :color

      t.timestamps
    end
  end
end
