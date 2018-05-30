require 'rails_helper'

describe 'user visits bikeshop ' do
  it 'can navigate to accessory show page' do
    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

    visit '/bike-shop'

    click_on accessory.title

    expect(current_path).to eq(accessory_path(accessory))
  end
  it 'as a admin can edit accessory' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

    visit '/admin/bike-shop'

    click_on 'Edit'

    expect(current_path).to eq(edit_admin_accessory_path(accessory))
  end
end
