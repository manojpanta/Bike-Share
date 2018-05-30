require 'rails_helper'

describe 'user visiting stations dashboard' do
  it 'as a user can see total count of stations' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    name = 'Foo'
    name1 = 'Foo1'
    dock_count = 5
    city = 'denver'
    installation_date = Time.now
    Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
    Station.create(name: name1, dock_count: dock_count, city: city, installation_date: installation_date)

    total_station_count = 'Total Stations: 2'


    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')
    expect(page).to have_content(total_station_count)
  end
end
