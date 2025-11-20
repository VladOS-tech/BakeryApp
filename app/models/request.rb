class Request < ApplicationRecord
  belongs_to :bakery
  belongs_to :user
  has_many :request_items, dependent: :destroy
end
