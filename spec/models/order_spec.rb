require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'relationships' do
    it {should belong_to(:user)}
    it {should have_many(:accessories).through(:accessory_orders)}
  end

  describe 'cost' do
    it 'should return its total cost' do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password:
      '1234', address: '123 Elm St')
      order = user.orders.create
      item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
      item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')
      order.accessory_orders.create(accessory: item1, quantity:2)
      order.accessories << item2

      total_cost = (item1.price * 2) + item2.price

      expect(order.cost).to eq(total_cost)
    end
  end
end
