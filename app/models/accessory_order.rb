class AccessoryOrder < ApplicationRecord
  validates_presence_of :quantity

  belongs_to :order
  belongs_to :accessory
end
