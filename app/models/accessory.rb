class Accessory < ApplicationRecord
  validates_presence_of :title, :price, :image, :description, :is_retired?

end
