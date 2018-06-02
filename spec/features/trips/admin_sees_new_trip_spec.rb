require 'rails_helper'

describe "An admin" do
  context "visits the admin new trip page" do
    it "and sees a form to add a new trip" do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
    duration = 100
<<<<<<< HEAD
    start_date = Time.zone.now
    start_station = station.id
    end_date = (Time.zone.now + 1)
=======
    start_date = Time.now.gmtime
    start_station = station.id
    end_date = (Time.now + 1).gmtime
>>>>>>> partial implementation of trips dashboard
    end_station = station.id
    bike_id = 4
    subscription_type = 'Member'
    zip_code = 80202

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in 'trip[duration]',	with: duration
    fill_in 'trip[start_date]',	with: start_date
    fill_in 'trip[start_station_id]',	with: station.id
    fill_in 'trip[end_date]',	with: end_date
    fill_in 'trip[end_station_id]',	with: station.id
    fill_in 'trip[bike_id]',	with: bike_id
    fill_in 'trip[subscription_type]',	with: subscription_type
    fill_in 'trip[zip_code]',	with: zip_code

    click_on 'Create Trip'

    expect(page).to have_content("Trip has been created!")
    expect(current_path).to eq(trip_path(Trip.last))
    expect(page).to have_content(duration)
    expect(page).to have_content(start_date.to_s[0..10])
    expect(page).to have_content(station.name)
    expect(page).to have_content(end_date.to_s[0..10])
    expect(page).to have_content(station.name)
    expect(page).to have_content(bike_id)
    expect(page).to have_content(subscription_type)
    expect(page).to have_content(zip_code)
    end
  end
end
