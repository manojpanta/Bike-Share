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
  it 'as a user can see most bikes in one station' do
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

    max_bike_count = 15


    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')
    expect(page).to have_content("Most Bikes available at a station: #{max_bike_count}")
  end
  it 'as a user can see station with most bikes' do
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

    top_station = s3.name


    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')
    expect(page).to have_content("Station with most bikes: #{top_station}")
  end
  it 'as a user can see station with most bikes' do
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

    low_station = s1.name


    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')
    expect(page).to have_content("Station with fewest bikes: #{low_station}")
  end

  it 'as a user can see fewest  bikes in one station' do
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

    min_bike_count = 5


    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')
    expect(page).to have_content("Fewest Bikes available at a station: #{min_bike_count}")
  end

  it 'it shows most recently installed station' do
    name = 'Foo'
    name1 = 'Foo1'
    name2 = 'Mnaoj'
    dock_count = 5
    dock_count1 = 10
    dock_count2 = 15
    city = 'denver'
    installation_date = '08/12/23'
    installation_date1 = '09/12/23'
    installation_date2 = '10/12/23'

    s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
    s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date1)
    s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date2)

    recent_station = s3.name
    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')

    expect(page).to have_content("Most recently installed station: #{recent_station}")
  end
  it 'it shows oldest station' do
    name = 'Foo'
    name1 = 'Foo1'
    name2 = 'Mnaoj'
    dock_count = 5
    dock_count1 = 10
    dock_count2 = 15
    city = 'denver'
    installation_date = '08/12/23'
    installation_date1 = '09/12/23'
    installation_date2 = '10/12/23'

    s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
    s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date1)
    s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date2)

    oldest_station = s1.name
    visit '/stations-dashboard'

    expect(current_path).to eq('/stations-dashboard')

    expect(page).to have_content("Oldest station: #{oldest_station}")
  end
end
