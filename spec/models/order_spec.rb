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

  describe 'as a admin in admin dashboard' do
    it 'total no. of order with ordered status' do
      user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

      order1 = user1.orders.create
      order2 = user1.orders.create(status: 'paid')

      item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
      item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')
      order1.accessory_orders.create(accessory: item1, quantity:2)

      order1.accessories << item2

      admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


      expect(Order.total_ordered).to eq(1)
    end
    it 'total no. of order with paid status' do
      user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

      order1 = user1.orders.create
      order2 = user1.orders.create(status: 'paid')

      item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
      item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')
      order1.accessory_orders.create(accessory: item1, quantity:2)

      order1.accessories << item2

      admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


      expect(Order.total_paid).to eq(1)
    end
    it 'total no. of order with cancelled status' do
      user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

      order1 = user1.orders.create
      order2 = user1.orders.create(status: 'paid')
      order2 = user1.orders.create(status: 'cancelled')

      item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
      item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')
      order1.accessory_orders.create(accessory: item1, quantity:2)

      order1.accessories << item2

      admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


      expect(Order.total_cancelled).to eq(1)
    end
  end
end
