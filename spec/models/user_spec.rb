require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:role)}
    it {should validate_uniqueness_of(:email)}
    it {should have_secure_password}
  end

  describe 'relationships' do
    it {should have_many(:orders)}
  end
end
