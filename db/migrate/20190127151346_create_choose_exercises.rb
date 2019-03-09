class CreateChooseExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :choose_exercises do |t|
      t.string :variants, null: false, array: true
      t.integer :answer, null: false

      t.timestamps
    end
  end
end
