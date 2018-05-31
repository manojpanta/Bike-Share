require 'rails_helper'

describe 'admin visits admin dashboard' do
  it 'can cancel order by clicking cancel next to paid orders' do
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

    expect(page).to have_content('cancelled')
    expect(page).to_not have_content('paid')
  end
  it 'can change status to paid from ordered' do
    user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

    order1 = user1.orders.create(status: 'ordered')

    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
    item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')

    order1.accessory_orders.create(accessory: item1, quantity:2)
    order1.accessories << item2

    admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit 'admin/dashboard'

    expect(page).to have_content(order1.id)
    expect(page).to have_content('ordered')

    within ('.orders-table') do
      click_on 'Mark as Paid'
    end

    expect(page).to have_content('paid')
    expect(page).to_not have_content('ordered')
  end
end
