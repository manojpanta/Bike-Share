require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({"1" => 2, "2" => 3})
      expect(cart.total_count).to eq(5)
    end
  end

  describe 'total_cost' do
    it 'can calculate its total cost' do
      item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
      item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')

      cart = Cart.new({item1.id.to_s => 2, item2.id.to_s => 3})

      total_cost = (item1.price * 2) + (item2.price * 3)

      expect(cart.total_cost).to eq(total_cost)
    end
  end
end
