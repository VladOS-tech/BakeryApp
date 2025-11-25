class User < ApplicationRecord
  has_many :bakery_users, dependent: :destroy
  has_many :bakeries, through: :bakery_users, dependent: :destroy
  has_many :requests, dependent: :destroy

  has_secure_password

  validates :phone, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[worker manager] }
  validates :name, presence: true
end
