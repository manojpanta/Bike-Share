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
end
