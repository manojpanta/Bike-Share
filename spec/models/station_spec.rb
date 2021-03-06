require 'rails_helper'
describe Station, type: :model do
  describe 'validations' do
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:installation_date)}
  end
  describe 'Relationships' do
    it {should have_many :trips_started}
    it {should have_many :trips_ended}
  end

  describe 'class method' do
    it 'calculates stations count' do
      name = 'Foo'
      name1 = 'Foo1'
      dock_count = 5
      city = 'denver'
      installation_date = Time.now
      Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      Station.create(name: name1, dock_count: dock_count, city: city, installation_date: installation_date)

      expect(Station.total_station_count).to eq(2)
    end
  end

  describe 'class method' do
    it 'calculates average bikes available' do
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

      expect(Station.avg_bikes_count).to eq(avg_bike_count)
    end
  end
  describe 'class method' do
    it 'calculates most bikes available in one station' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Foo2'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      most_bike_available_in_one_station = 15

      expect(Station.most_bikes_in_one_station).to eq(most_bike_available_in_one_station)
    end
  end
  describe 'class method' do
    it 'it shows station with most bikes count' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Mnaoj'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      top_station = s3.name

      expect(Station.station_with_most_bikes.first.name).to eq(top_station)
    end
  end

  describe 'class method' do
    it 'calculates  fewest bikes available in one station' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Foo2'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      fewest_bike_available_in_one_station = 5

      expect(Station.fewest_bikes_in_one_station).to eq(fewest_bike_available_in_one_station)
    end
  end

  describe 'class method' do
    it 'it shows station with fewest bikes count' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Mnaoj'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      low_station = s1.name

      expect(Station.station_with_fewest_bikes.first.name).to eq(low_station)
    end
  end

  describe 'class method' do
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

      expect(Station.most_recently_installed.name).to eq(recent_station)
    end
  end

  describe 'class method' do
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

      expect(Station.oldest_station.name).to eq(oldest_station)
    end
  end

  describe "class methods" do
    it "#started_here should return number of trips started from this station." do
      name = 'Foo'
      name1 = 'Foo1'
      dock_count = 5
      city = 'denver'
      installation_date = Time.now

      station = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      station1 = Station.create(name: name1, dock_count: dock_count, city: city, installation_date: installation_date)
      Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 5, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station, bike_id: 5, subscription_type: 'Member', zip_code: 80202 )

      rides_started = 2

      expect(station.started_here).to eq(rides_started)
    end
  end

  describe "class methods" do
    it "#ended_here should return number of trips ended from this station." do
      name = 'Foo'
      name1 = 'Foo1'
      dock_count = 5
      city = 'denver'
      installation_date = Time.now

      station = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      station1 = Station.create(name: name1, dock_count: dock_count, city: city, installation_date: installation_date)
      Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 5, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station, bike_id: 5, subscription_type: 'Member', zip_code: 80202 )

      rides_ended = 3

      expect(station.ended_here).to eq(rides_ended)
    end
  end

  describe "class methods" do
    it "#frequent_destination returns the name of the most frequent desination from this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 75, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 80, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      frequent_destinations = 'Denver-Cap Hill'

      expect(station.frequent_destination).to eq(frequent_destinations)
      expect(station.frequent_destination).to_not eq('Jack')
    end
  end

  describe "class methods" do
    it "#frequent_origination returns the name of the most frequent desination from this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 0)
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 75, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 80, start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      frequent_originations = 'Denver-Cap Hill'

      expect(station.frequent_origination).to eq(frequent_originations)
      expect(station.frequent_origination).to_not eq('Jack')
    end
  end

  describe "class methods" do
    it "#most_rides_started returns the date where the most rides started from this station." do
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      date1 = Date.new(2018, 2, 4)
      date2 = Date.new(2018, 2, 1)
      Trip.create(duration: 100, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 75, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      Trip.create(duration: 80, start_date: date2, start_station: station2, end_date: (Time.now + 15), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      expect(station.most_rides_started).to eq(date1.strftime('%A, %B %e, %Y'))
      expect(station.most_rides_started).to_not eq(date2)
    end
  end

  describe "class methods" do
    it "#most_frequent_zip returns the most frequent zip code for users starting trips at this station." do
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      date1 = Date.new(2018, 2, 4)
      date2 = Date.new(2018, 2, 1)
      zip1 = 80202
      zip2 = 80231

      Trip.create(duration: 100, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 75, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 80, start_date: date2, start_station: station2, end_date: (Time.now + 15), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: zip2 )

      expect(station.most_frequent_zip).to eq(zip1)
      expect(station.most_frequent_zip).to_not eq(zip2)
    end
  end

  describe "class methods" do
    it "#most_used_bike returns the Bike ID most frequently starting a trip at this station." do
      station = Station.create(name:'Denver-Cap Hill', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create(name:'Jack', dock_count: 5, city: 'New Jack City', installation_date: Time.now)
      date1 = Date.new(2018, 2, 4)
      date2 = Date.new(2018, 2, 1)
      zip1 = 80202
      zip2 = 80231
      bikeid1 = 4
      bikeid2 = 3


      Trip.create(duration: 100, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: bikeid1, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 75, start_date: date1, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: bikeid1, subscription_type: 'Member', zip_code: zip1 )
      Trip.create(duration: 80, start_date: date2, start_station: station2, end_date: (Time.now + 15), end_station: station2, bike_id: bikeid2, subscription_type: 'Member', zip_code: zip2 )

      expect(station.most_used_bike).to eq(bikeid1)
      expect(station.most_used_bike).to_not eq(bikeid2)
    end
  end

end
