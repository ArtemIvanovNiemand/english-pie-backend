class CreateMatchExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :match_exercises do |t|
      t.string :left_variants, null: false, array: true
      t.string :right_variants, null: false, array: true

      t.integer :answer, null: false, array: true

      t.timestamps
    end
  end
end
