require 'rails_helper'

describe 'user can create a new station' do
  it 'as an admin can create new station' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    name = 'Foo'
    dock_count = 5
    city = 'denver'
    installation_date = Time.now

    visit new_admin_station_path

    fill_in 'station[name]', with: name
    fill_in 'station[dock_count]', with: dock_count
    fill_in 'station[city]', with: city
    fill_in 'station[installation_date]', with: installation_date
    click_on 'Create Station'

    expect(current_path).to eq(station_path(Station.last))
    expect(page).to have_content("Foo station created!")
    expect(page).to have_content(name)
    expect(page).to have_content(dock_count)
    expect(page).to have_content(city)
  end

  it 'as an admin can navigate to new station from station index' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    name = 'Foo'
    dock_count = 5
    city = 'denver'
    installation_date = Time.now

    visit stations_path

    click_on 'Create New Station'

    expect(current_path).to eq(new_admin_station_path)
  end
end
