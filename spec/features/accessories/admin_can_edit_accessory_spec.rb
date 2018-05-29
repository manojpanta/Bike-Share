require 'rails_helper'

describe 'user visits admin edit accessory path' do
  it 'as an admin can edit accessory' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = 'wranch'
    description = 'this is awesome wranch'
    price = 123
    image = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'
    title1 = 'wranch updated'
    description1 = 'this is awesome updated wranch'
    price1 = 1234
    image1 = 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg'

    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

    visit edit_admin_accessory_path(accessory)


    fill_in 'accessory[title]', with: title1
    fill_in 'accessory[description]', with: description1
    fill_in 'accessory[price]', with: price1
    fill_in 'accessory[image]', with: image1

    click_on 'Update Accessory'



    expect(current_path).to eq(accessory_path(accessory))
    expect(page).to have_content(title1)
    expect(page).to have_content(description1)
    expect(page).to have_content(price1)
  end
end
