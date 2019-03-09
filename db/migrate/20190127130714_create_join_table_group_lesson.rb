class CreateJoinTableGroupLesson < ActiveRecord::Migration[5.2]
  def change
    create_join_table :groups, :lessons do |t|
      t.integer :order

      t.index %i[group_id lesson_id]
    end
  end
end
