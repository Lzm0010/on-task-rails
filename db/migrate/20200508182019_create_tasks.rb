class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :step_number
      t.references :project, foreign_key: true
      t.references :goal, foreign_key: true
      t.references :planner, foreign_key: true
      t.string :status
      t.boolean :is_completed
      t.datetime :date

      t.timestamps
    end
  end
end
