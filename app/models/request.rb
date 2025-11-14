class Request < ApplicationRecord
  belongs_to :bakery
  has_many :request_items, dependent: :destroy
end
