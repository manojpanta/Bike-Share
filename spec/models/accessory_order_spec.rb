require 'rails_helper'

RSpec.describe AccessoryOrder, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:quantity)}
  end

  describe 'relationships' do
    it {should belong_to(:order)}
    it {should belong_to(:accessory)}
  end

  describe 'subtotal' do
    it 'displays subtotal for item' do
      user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')
      order1 = user1.orders.create
      item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
      quantity = 2
      ao = order1.accessory_orders.create(accessory: item1, quantity:quantity)

      subtotal = item1.price * quantity

      expect(ao.subtotal).to eq(subtotal)
    end
  end
end
