require 'rails_helper'

describe 'user visits bikeshop page' do
  it 'can see accessories on sale' do
    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')
    visit '/bike-shop'

    expect(page).to have_content(accessory.title)
    expect(page).to have_link('Add to cart')
  end
end
