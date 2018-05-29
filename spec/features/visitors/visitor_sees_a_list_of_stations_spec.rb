require 'rails_helper'

describe "A visitor" do
  context "visits the stations index page" do
    it "and should see all the stations with name, dock count, city, and installation date" do
      station1 = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name: 'Bar', dock_count: 4, city: 'Aurora', installation_date: Time.now)

      visit stations_path


      expect(page).to have_content(station1.name)
      expect(page).to have_content(station1.dock_count)
      expect(page).to have_content(station1.city)
      expect(page).to have_content(station2.installation_date)
      expect(page).to have_content(station2.name)
      expect(page).to have_content(station2.dock_count)
      expect(page).to have_content(station2.city)
      expect(page).to have_content(station2.installation_date)

    end

    it 'can navigate to a station page' do
      station1 = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name: 'Bar', dock_count: 4, city: 'Aurora', installation_date: Time.now)

      visit stations_path

      click_on station1.name

      expect(current_path).to eq(station_path(station1))
    end
  end
end
