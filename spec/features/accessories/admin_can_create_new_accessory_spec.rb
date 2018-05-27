require 'rails_helper'

describe 'user visits bikeshop page' do
  it 'can see accessories on sale' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')
    visit admin_bikeshop_new_path

    expect(page).to have_content('New Accessory')
  end
end
