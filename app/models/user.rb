class User < ApplicationRecord
  has_many :bakery_users
  has_many :bakeries, through: :bakery_users
  has_many :requests # если заявка создана этим пользователем

  has_secure_password

  validates :phone, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[worker manager] }
end
