require 'rails_helper'

describe Trip, type: :model do
  it {should validate_presence_of(:start_date)}
  it {should validate_presence_of(:end_date)}
  it {should validate_presence_of(:bike_id)}
  it {should validate_presence_of(:subscription_type)}
end
