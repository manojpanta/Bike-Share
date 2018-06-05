class Accessory < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0}
  validates_presence_of :image, :description
  has_many :accessory_orders
  has_many :orders, through: :accessory_orders
end
