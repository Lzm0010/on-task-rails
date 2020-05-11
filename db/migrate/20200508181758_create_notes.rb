class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :planner, null: false, foreign_key: true
      t.text :content
      t.datetime :date

      t.timestamps
    end
  end
end
