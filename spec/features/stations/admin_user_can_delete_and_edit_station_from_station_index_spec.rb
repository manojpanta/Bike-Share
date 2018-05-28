require 'rails_helper'

describe 'admin visiting station index page' do
  it 'can see delete and edit button' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)

    visit stations_path

    expect(page).to have_link('Delete')
    expect(page).to have_link('Edit')
  end
  it 'can  edit station' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)

    visit stations_path

    click_on 'Edit'

    expect(current_path).to eq(edit_admin_station_path(station))
  end
  it 'can  delete station' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)

    visit stations_path

    click_on 'Delete'

    expect(current_path).to eq(stations_path)
    expect(page).to_not have_content(station.name)
  end
end
