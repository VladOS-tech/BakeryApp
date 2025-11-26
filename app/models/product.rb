class Product < ApplicationRecord
  belongs_to :warehouse
  has_many :request_items, dependent: :restrict_with_error
  has_many :purchase_items, dependent: :restrict_with_error

  scope :active, -> { where(active: true) }
end
