require 'rails_helper'

describe 'admin visits admin bikeshop page ' do
  it 'can click on create new accessory to go to admin bikeshop new path' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_bike_shop_path

    click_on 'Create New Accessory'

    expect(current_path).to eq(admin_bikeshop_new_path)
  end
end
