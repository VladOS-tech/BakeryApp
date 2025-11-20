class CreateBakeryUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :bakery_users do |t|
      t.references :bakery, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bakery_users, [ :bakery_id, :user_id ], unique: true
  end
end
