require 'rails_helper'

describe 'visitor visits cart show' do
  it 'shows items in cart' do
    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')

    visit '/bike-shop'
    click_on 'Add to cart'
    visit '/cart'

    expect(page).to have_content(item1.title)
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Total Cost: #{item1.price}")
  end
end
