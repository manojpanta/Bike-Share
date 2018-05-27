class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :accessory_orders
  has_many :accessories, through: :accessory_orders
end
