require 'rails_helper'

describe 'registered user visits dashboard' do
  it 'total no. of order with ordered status' do
    user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

    order1 = user1.orders.create
    order2 = user1.orders.create(status: 'paid')
    order2 = user1.orders.create(status: 'cancelled')
    order2 = user1.orders.create(status: 'completed')

    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
    item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')
    order1.accessory_orders.create(accessory: item1, quantity:2)

    order1.accessories << item2

    admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit 'admin/dashboard'
    orders_paid = "Total Number Of Orders With Ordered Status: 1 "

    expect(page).to have_content(orders_paid)
  end
end
