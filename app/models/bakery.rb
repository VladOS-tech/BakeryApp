class Bakery < ApplicationRecord
  has_many :bakery_users
  has_many :users, through: :bakery_users
  has_many :requests
end
