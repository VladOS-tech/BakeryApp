class Product < ApplicationRecord
  belongs_to :warehouse
  has_many :request_items
  has_many :purchase_items
end
