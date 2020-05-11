class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :step_number
      t.references :project, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.references :planner, null: false, foreign_key: true
      t.string :status
      t.boolean :is_completed
      t.datetime :date

      t.timestamps
    end
  end
end
