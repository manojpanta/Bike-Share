require 'rails_helper'

describe 'admin visits admin dashboard' do
  it 'can filter orders by status' do
    user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

    order1 = user1.orders.create(status: 'paid')

    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
    item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')

    order1.accessory_orders.create(accessory: item1, quantity:2)
    order1.accessories << item2

    admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit 'admin/dashboard'

    expect(page).to have_content(order1.id)
    expect(page).to have_content('paid')

    within ('.orders-table') do
      click_on 'Cancel'
    end

    expect(page).to have_content('Cancelled')
    expect(page).to_not have_content('paid')
  end
end
