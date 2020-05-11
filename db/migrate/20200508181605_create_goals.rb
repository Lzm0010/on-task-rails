class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.string :goal_type
      t.integer :goal_total_days
      t.float :goal_percentage
      t.references :user, null: false, foreign_key: true
      t.string :frequency

      t.timestamps
    end
  end
end
