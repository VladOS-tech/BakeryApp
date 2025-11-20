class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :phone, null: false
      t.string :password_digest, null: false
      t.string :role, null: false, default: "worker"

      t.timestamps
    end
    add_index :users, :phone, unique: true
  end
end
