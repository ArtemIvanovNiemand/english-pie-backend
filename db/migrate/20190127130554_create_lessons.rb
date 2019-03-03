class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description

      t.references :group, index: true

      t.timestamps
    end
  end
end
