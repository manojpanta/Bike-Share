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
  it 'as a user can see average bikes per station' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    name = 'Foo'
    name1 = 'Foo1'
    name2 = 'Foo2'
    dock_count = 5
    dock_count1 = 10
    dock_count2 = 15
    city = 'denver'
    installation_date = Time.now
    s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
    s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
    s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

    avg_bike_count = (s1.dock_count + s2.dock_count + s3.dock_count) / 3


    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')
    expect(page).to have_content("Average Bike Count Per Station: #{avg_bike_count}")
  end
end
