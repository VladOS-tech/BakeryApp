class BakeryUser < ApplicationRecord
  belongs_to :user
  belongs_to :bakery
end
