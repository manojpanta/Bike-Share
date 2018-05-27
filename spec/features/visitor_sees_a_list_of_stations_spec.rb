require 'rails_helper'

describe "A visitor" do
  context "visits the stations index page" do
    it "and should see all the stations with name, dock count, city, and installation date" do
      station1 = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name: 'Bar', dock_count: 4, city: 'Aurora', installation_date: Time.now)
      
      visit '/stations'


      expect(page).to have_content(station1.name)
      expect(page).to have_content(station1.dock_count)
      expect(page).to have_content(station1.city)
      expect(page).to have_content(station2.installation_date)
      expect(page).to have_content(station2.name)
      expect(page).to have_content(station2.dock_count)
      expect(page).to have_content(station2.city)
      expect(page).to have_content(station2.installation_date)

    end
  end
end

As a visitor,
When I visit the stations index,
I see all stations (name, dock count, city, installation date)