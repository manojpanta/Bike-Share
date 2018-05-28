require 'rails_helper'

describe 'user can edit a station' do
  it 'as an admin can edit a station' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)

    name = 'staion'
    dock_count = 10
    city = 'Colorado'
    installation_date = Time.now

    visit edit_admin_station_path(station)

    fill_in 'station[name]', with: name
    fill_in 'station[dock_count]', with: dock_count
    fill_in 'station[city]', with: city
    fill_in 'station[installation_date]', with: installation_date
    click_on 'Update Station'

    expect(current_path).to eq(station_path(Station.last))
    expect(page).to have_content("#{name} station updated!")
    expect(page).to have_content(name)
    expect(page).to have_content(dock_count)
    expect(page).to have_content(city)
  end
end
