require 'rails_helper'

describe "An admin" do
  context "visits the admin new trip page" do
    it "and sees a form to add a new trip" do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in :duration,	with: 100
    fill_in :start_date,	with: Time.now
    fill_in :start_station,	with: :start_station.name
    fill_in :end_date,	with: (Time.now + 100)
    fill_in :end_station,	with: :end_station.name
    fill_in :bike_id,	with: 5
    fill_in :subscription_type,	with: "yes"
    fill_in :zip_code,	with: 80202

    click_on 'Create Trip'

    expect(current_page).to eq(admin_trip)
    end
  end
end
