require 'rails_helper'

RSpec.describe AccessoryOrder, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:quantity)}
  end

  describe 'relationships' do
    it {should belong_to(:order)}
    it {should belong_to(:accessory)}
  end
end
