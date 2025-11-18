class RequestItem < ApplicationRecord
  belongs_to :request
  belongs_to :product
end
