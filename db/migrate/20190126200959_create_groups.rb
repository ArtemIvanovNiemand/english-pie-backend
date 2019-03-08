class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :description
      t.string :level

      t.string :token, index: true, unique: true

      t.timestamps
    end
  end
end
