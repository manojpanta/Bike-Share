class Accessory < ApplicationRecord
  validates_presence_of :title, :price, :image, :description, :is_retired?
  has_many :accessory_orders
  has_many :orders, through: :accessory_orders
end
