require 'rails_helper'

describe 'registered user visits dashboard' do
  it 'links to users orders' do
    user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')
    user2 = User.create(name: 'blob', email: 'blob@blob.blob', password: '1234', address: '321 Elm St')
    order1 = user1.orders.create
    order2 = user1.orders.create
    order3 = user2.orders.create
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
    item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')
    ao1 = order1.accessory_orders.create(accessory: item1, quantity:2)
    order1.accessories << item2
    order2.accessories << item1
    order3.accessory_orders.create(accessory: item2, quantity: 3)

    admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit order_path(order1)

    status = 'ordered'
    subtotal1 = item1.price * 2
    expect(page).to have_link(item1.title)
    expect(page).to have_content(ao1.quantity)
    expect(page).to have_link(item2.title)
    expect(page).to have_content(subtotal1)
    expect(page).to have_content(status)
    expect(page).to have_content(order1.created_at)
    expect(page).to_not have_content("Time Completed: ")
    expect(page).to_not have_content("Time Canceled: ")

    expect(page).to have_content(user1.name)
    expect(page).to have_content(user1.address)

    visit order_path(order3)

    expect(page).to have_content(user2.name)
    expect(page).to_not have_content(user1.name)
  end
end
