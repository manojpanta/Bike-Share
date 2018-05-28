class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :accessory_orders
  has_many :accessories, through: :accessory_orders

  def cost
    accessory_orders.reduce(0) do |sum, ao|
      sum + ao.quantity * ao.accessory.price
    end
  end
end
