class User < ApplicationRecord

  validates_presence_of :name
  validates_presence_of :password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :address
  validates_presence_of :role

  has_secure_password
  enum role: %i[default admin]
  has_many :orders
end
