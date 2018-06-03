require 'rails_helper'

describe 'visitor visits cart show' do
  it 'shows items in cart' do
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')

    visit '/bike-shop'
    click_on 'Add to cart'
    visit '/cart'

    expect(page).to have_content(item1.title)
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Price: #{item1.price}")
    expect(page).to have_content("Subtotal: #{item1.price}")
    expect(page).to have_content("Total Cost: #{item1.price}")

    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123')
    visit '/'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/cart'

    expect(page).to have_content(item1.title)
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Total Cost: #{item1.price}")
  end

  it 'can remove items in cart' do
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')

    visit '/bike-shop'
    click_on 'Add to cart'
    visit '/cart'
    click_on 'Remove'

    expect(page).to have_content("Successfully removed #{item1.title} from your cart")
    expect(page).to have_link(item1.title)
    expect(page).to_not have_content("Quantity: 1")
    expect(page).to_not have_content("Total Cost: #{item1.price}")
  end

  it 'can increase quantity for items in cart' do
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')

    visit '/bike-shop'
    click_on 'Add to cart'
    visit '/cart'

    click_on '+'

    expect(current_path).to eq('/cart')
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_content("Subtotal: #{item1.price * 2}")
    expect(page).to have_content("Total Cost: #{item1.price * 2}")
  end

  it 'can decrease quantity for items in cart' do
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')

    visit '/bike-shop'
    click_on 'Add to cart'
    visit '/cart'
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Subtotal: #{item1.price}")
    click_on '+'
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_content("Subtotal: #{item1.price * 2}")

    click_on '-'
    expect(current_path).to eq('/cart')
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Subtotal: #{item1.price}")

    click_on '-'
    expect(page).to have_content("Successfully removed #{item1.title} from your cart")
    expect(page).to have_link(item1.title)
    expect(page).to_not have_content("Quantity: 1")
    expect(page).to_not have_content("Total Cost: #{item1.price}")
  end
end
