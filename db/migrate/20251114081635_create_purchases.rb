class CreatePurchases < ActiveRecord::Migration[8.1]
  def change
    create_table :purchases do |t|
      t.date :purchase_date

      t.timestamps
    end
  end
end
