class Warehouse < ApplicationRecord
  has_many :products
  has_many :purchase_items
end
