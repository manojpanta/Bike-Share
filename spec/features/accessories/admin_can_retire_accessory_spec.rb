require 'rails_helper'

describe 'user visits accessory path' do
  it 'as an admin can retire accessory' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = 'wranch'
    description = 'this is awesome wranch'
    price = 123
    image = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'

    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

    visit accessory_path(accessory)
    # save_and_open_page
    expect(page).to have_link('Add to cart')

    click_on 'Retire'

    expect(page).to_not have_link('Add to cart')
  end
  it 'as an admin can reactivate accessory' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = 'wranch'
    description = 'this is awesome wranch'
    price = 123
    image = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'

    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool', is_retired?: true)

    visit accessory_path(accessory)

    expect(page).to_not have_content('Add to cart')

    click_on 'Reactivate'

    expect(page).to have_link('Add to cart')
  end
  it 'as an admin can retire accessory from accessory index page' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = 'wranch'
    description = 'this is awesome wranch'
    price = 123
    image = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'

    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

    visit 'admin/bike-shop'

    expect(page).to have_button('Add to cart')

    click_on 'Retire'


    expect(current_path).to eq(accessory_path(accessory))
    expect(page).to_not have_content('Add to cart')
  end
  it 'as an admin can reactivate accessory from accessory index page' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = 'wranch'
    description = 'this is awesome wranch'
    price = 123
    image = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'

    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool', is_retired?: true)

    visit 'admin/bike-shop'

    expect(page).to_not have_content('Add to cart')

    click_on 'Reactivate'


    expect(current_path).to eq(accessory_path(accessory))
    expect(page).to have_link('Add to cart')
  end
end
