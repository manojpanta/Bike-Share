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
    order1.accessory_orders.create(accessory: item1, quantity:2)
    order1.accessories << item2
    order2.accessories << item1
    order3.accessory_orders.create(accessory: item2, quantity: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/dashboard'

    expect(page).to have_link(order2.id)
    expect(page).to_not have_link(order3.id)

    click_on order1.id

    expect(current_path).to eq(order_path(order1))

    status = 'ordered'
    subtotal1 = item1.price * 2
    expect(page).to have_link(item1.title)
    expect(page).to have_link(item2.title)
    expect(page).to have_content(subtotal1)
    expect(page).to have_content(status)
    expect(page).to have_content(order1.date_created)

  end
end
