class CreateRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :requests do |t|
      t.references :bakery, null: false, foreign_key: true
      t.date :request_date

      t.timestamps
    end
  end
end
