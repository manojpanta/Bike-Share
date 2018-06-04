require 'rails_helper'

describe 'user visits cart show' do
  it 'shows items in cart' do

    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item1 = Accessory.create(title: 'chain', image: 'chain.jpg', price: 27.55, description: 'pedal to wheel')

    visit '/bike-shop'
    click_on 'Add to cart'


    visit '/cart'

    click_on 'Checkout'

    expect(page).to have_content("Successfully submitted your order totaling $ 27.55")
    expect(current_path).to eq(dashboard_path(user))
  end
end
