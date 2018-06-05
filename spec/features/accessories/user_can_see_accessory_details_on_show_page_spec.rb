require 'rails_helper'

describe 'user visits bikeshop page' do
  it 'can see accessories on sale' do
    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')
    visit accessory_path(accessory)

    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
    expect(page).to have_button('Add to cart')
  end
  it 'doesnt show add to cart for retored accessory' do
    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool', is_retired?: true)
    visit accessory_path(accessory)

    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
    expect(page).to have_content('Accessory Retired')
    expect(page).to_not have_link('Add to cart')
  end
end
