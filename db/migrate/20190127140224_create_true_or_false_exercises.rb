class CreateTrueOrFalseExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :true_or_false_exercises do |t|
      t.boolean :answer, null: false

      t.timestamps
    end
  end
end
