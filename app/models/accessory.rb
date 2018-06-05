class Accessory < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates_presence_of :price, :image, :description
  has_many :accessory_orders
  has_many :orders, through: :accessory_orders
end
