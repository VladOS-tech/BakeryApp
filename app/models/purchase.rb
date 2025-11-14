class Purchase < ApplicationRecord
  has_many :purchase_items, dependent: :destroy
end
