class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.integer :lesson_id
      t.references :exercise, polymorphic: true

      t.string :name, null: false
      t.string :description, null: false

      t.integer :sort_order, null: false

      t.timestamps
    end
  end
end
