require 'rails_helper'

describe 'user visits bikeshop new page' do
  it 'as an admin can create new accessory' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    title = 'wranch'
    description = 'this is awesome wranch'
    price = 123
    image = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'

    visit admin_bikeshop_new_path

    fill_in 'accessory[title]', with: title
    fill_in 'accessory[description]', with: description
    fill_in 'accessory[price]', with: price
    fill_in 'accessory[image]', with: image
    click_on 'Create Accessory'


    expect(page).to have_content(title)
    expect(page).to have_content(description)
    expect(page).to have_content(price)
  end
end
