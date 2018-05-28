require 'rails_helper'

describe 'registered user visits dashboard' do
  it 'links to users orders' do
    user = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')
    order1 = user.orders.create
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
    order1.accessory_orders << AccessoryOrder.create(accessory: item1, quantity:2)

    # binding.pry
  end
end
