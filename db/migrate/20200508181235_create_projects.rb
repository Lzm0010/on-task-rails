class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
