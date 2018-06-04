require 'rails_helper'

describe 'admin visits admin dashboard' do
  it 'can filter orders by status' do
    user1 = User.create(name: 'bob', password: '1234', email: 'bob@bob.bob', address: '123 Elm St')

    order1 = user1.orders.create(status: 'ordered')
    order2 = user1.orders.create(status: 'paid')
    order3 = user1.orders.create(status: 'cancelled')
    order4 = user1.orders.create(status: 'completed')

    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')
    item2 = Accessory.create(title: 'pedal', image: 'pedal.jpg', price: 36.55, description: 'goes around')

    order1.accessory_orders.create(accessory: item1, quantity:2)
    order1.accessories << item2

    admin = User.create(name: 'admin', password: '1234', email: 'admin@bob.bob', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit 'admin/dashboard'

    within('.orders-table') do
      expect(page).to have_content('All Orders')
      expect(page).to have_link(order1.id)
      expect(page).to have_link(order2.id)
      expect(page).to have_link(order3.id)
      expect(page).to have_link(order4.id)
    end

    click_on 'Ordered'

    expect(page).to have_content('All Ordered Orders')

    within('.orders-table') do
      expect(page).to have_link(order1.id)
      expect(page).to_not have_link(order2.id)
      expect(page).to_not have_link(order3.id)
      expect(page).to_not have_link(order4.id)
    end

    click_on 'Paid'

    expect(page).to have_content('All Paid Orders')
    expect(page).to have_content(order2.id)

    expect(page).to_not have_content(order1.id)
    expect(page).to_not have_content(order3.id)
    expect(page).to_not have_content(order4.id)

    click_on 'Cancelled'

    expect(page).to have_content('All Cancelled Orders')
    expect(page).to have_content(order3.id)

    expect(page).to_not have_content(order1.id)
    expect(page).to_not have_content(order2.id)
    expect(page).to_not have_content(order4.id)

    click_on 'Completed'

    expect(page).to have_content('All Completed Orders')
    expect(page).to have_content(order4.id)

    expect(page).to_not have_content(order1.id)
    expect(page).to_not have_content(order2.id)
    expect(page).to_not have_content(order3.id)
  end
end
