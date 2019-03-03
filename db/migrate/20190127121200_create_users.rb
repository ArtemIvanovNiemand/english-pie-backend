class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: true, unique: true
      t.string :password_digest
      t.string :access_level, null: false

      t.references :group, index: true, forge_key: true, null: true

      t.timestamps
    end
  end
end
