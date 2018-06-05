require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:end_date)}
    it {should validate_presence_of(:bike_id)}
    it {should validate_presence_of(:subscription_type)}
  end
  describe 'Relationships' do
    it {should belong_to :start_station}
    it {should belong_to :end_station}
  end

  describe 'class methods' do
    it 'groups by subscription' do
      station = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Subscriber', zip_code: 80202 )

      subs = Trip.subscriptions

      expect(subs.first.subscription_type).to eq("Member")
      expect(subs.last.subscription_type).to eq("Subscriber")
    end

    it 'groups by bike id' do
      station = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      bikes = Trip.bikes

      expect(bikes.first.bike_id).to eq(4)
      expect(bikes.last.bike_id).to eq(2)
    end

    it 'finds station with most ends' do
      station1 = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create!(name: 'Bar', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station1, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      ends = Trip.most_ends

      expect(ends).to eq(station2)
    end

    it 'finds station with most most_starts' do
      station1 = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create!(name: 'Bar', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station1, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      starts = Trip.most_starts

      expect(starts).to eq(station1)
    end

    it 'finds the shortest duration' do
      station1 = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create!(name: 'Bar', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(duration: 5, start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station1, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(duration: 10, start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(duration: 15, start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      shortest = Trip.shortest

      expect(shortest).to eq(trip1.id)
    end

    it 'finds the longest duration' do
      station1 = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create!(name: 'Bar', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(duration: 5, start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station1, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(duration: 10, start_date: Time.now, start_station: station1, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(duration: 15, start_date: Time.now, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      longest = Trip.longest

      expect(longest).to eq(trip3.id)
    end

    it 'groups by date' do
      station1 = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create!(name: 'Bar', dock_count: 5, city: 'Denver', installation_date: Time.now)
      date1 = DateTime.strptime('8/29/13 16:18', '%m/%d/%y %H:%M')
      date2 = DateTime.strptime('8/29/14 16:18', '%m/%d/%y %H:%M')
      trip1 = Trip.create!(duration: 5, start_date: date1, start_station: station1, end_date: (Time.now + 1), end_station: station1, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(duration: 10, start_date: date1, start_station: station1, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(duration: 15, start_date: date2, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      dates = Trip.dates

      expect(dates.first.start_date).to eq(date1)
      expect(dates.first.date_count).to eq(2)
      expect(dates.last.start_date).to eq(date2)
      expect(dates.last.date_count).to eq(1)
    end

    it 'groups by month' do
      station1 = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      station2 = Station.create!(name: 'Bar', dock_count: 5, city: 'Denver', installation_date: Time.now)
      date1 = DateTime.strptime('8/29/13 16:18', '%m/%d/%y %H:%M')
      date2 = DateTime.strptime('8/29/14 16:18', '%m/%d/%y %H:%M')
      trip1 = Trip.create!(duration: 5, start_date: date1, start_station: station1, end_date: (Time.now + 1), end_station: station1, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(duration: 10, start_date: date1, start_station: station1, end_date: (Time.now + 1), end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip3 = Trip.create!(duration: 15, start_date: date2, start_station: station2, end_date: (Time.now + 1), end_station: station2, bike_id: 2, subscription_type: 'Subscriber', zip_code: 80202 )

      months = Trip.months

      expect(months[months.keys.max]).to eq(1)
      expect(months[months.keys.min]).to eq(2)
    end
  end
end
