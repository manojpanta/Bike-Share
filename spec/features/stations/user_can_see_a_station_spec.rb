require 'rails_helper'

describe "A registered user" do
  context "visits a station show page" do
    it "and sees the number of rides started at this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to have_content("Rides started here:\n1\n")
      Trip.create(duration: 90, start_date: (Time.now + 2), start_station: station, end_date: (Time.now + 3), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit station_path(station)

      expect(page).to have_content("Rides started here:\n2\n")
    end

    it "and sees the number of rides ended at this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to have_content("Rides ended here:\n1\n")

      Trip.create(duration: 90, start_date: (Time.now + 2), start_station: station, end_date: (Time.now + 3), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit station_path(station)

      expect(page).to have_content("Rides ended here:\n2\n")
    end

    it "and sees the most frequent destination station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 75, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 80, start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to have_content("Most frequent destination:\nDenver-Cap Hill\n")
      expect(page).to_not have_content("Most frequent destination:\nJack\n")
    end

    it "and sees the most frequent origination station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 75, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 80, start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to have_content("Most frequent origination:\nDenver-Cap Hill\n")
      expect(page).to_not have_content("Most frequent origination: Jack")
    end

    it "and sees the Date with the highest number of trips started at this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      date1 = Date.new(2018, 2, 4)
      date2 = Date.new(2018, 2, 1)
      Trip.create(duration: 100, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 75, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 80, start_date: date2, start_station: station2, end_date: (Time.now + 15), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to have_content("Date with the most rides started:\n#{date1.strftime('%A, %B%e, %Y')}")
      expect(page).to_not have_content("Date with the most rides started: 03/04/2018")
    end

    it "and sees the Most frequent zip code for users starting trips at this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      date1 = Date.new(2018, 2, 4)
      date2 = Date.new(2018, 2, 1)
      zip1 = 80202
      zip2 = 80231

      Trip.create(duration: 100, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 75, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 80, start_date: date2, start_station: station2, end_date: (Time.now + 15), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: zip2 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to have_content("Most frequent zip code:\n#{zip1}")
      expect(page).to_not have_content("Most frequent zip code:\n#{zip2}")
    end

    it "and sees the the Bike ID most frequently starting a trip at this station." do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      date1 = Date.new(2018, 2, 4)
      date2 = Date.new(2018, 2, 1)
      zip1 = 80202
      zip2 = 80231
      bikeid1 = 4
      bikeid2 = 3
      Trip.create(duration: 100, start_date: date1, start_station: station, end_date: (Time.zone.now + 1), end_station: station, bike_id: bikeid1, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 75, start_date: date1, start_station: station, end_date: (Time.zone.now + 1), end_station: station, bike_id: bikeid1, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 80, start_date: date2, start_station: station2, end_date: (Time.zone.now + 15), end_station: station2, bike_id: bikeid2, subscription_type: 'Member', zip_code: zip2 )
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit station_path(station)
      save_and_open_page

      expect(page).to have_content("Most used bike:\n#{bikeid1}")
      expect(page).to_not have_content("Most used bike:\n#{bikeid2}")
    end

  end
end


# I see the Bike ID most frequently starting a trip at this station.