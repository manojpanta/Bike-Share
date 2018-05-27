require 'rails_helper'

RSpec.describe Accessory, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:image)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:price)}
  end

  describe 'relationship' do
    it {should have_many(:orders).through(:accessory_orders)}
  end
end
