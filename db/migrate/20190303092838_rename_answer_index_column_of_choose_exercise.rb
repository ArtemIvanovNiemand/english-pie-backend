class RenameAnswerIndexColumnOfChooseExercise < ActiveRecord::Migration[5.2]
  def change
    rename_column :choose_exercises, :answer_index, :answer
  end
end
