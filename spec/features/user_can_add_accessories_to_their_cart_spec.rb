require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit /bike-shop' do
    describe 'when I click on Add to cart' do
      it 'adds a accessory to the cart' do
        accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

        visit '/bike-shop'

        click_on 'Add to cart'

        expect(current_path).to eq('/bike-shop')
        expect(page).to have_content("You now have 1 #{accessory.title} in your cart.")
      end
    end
  end
end
