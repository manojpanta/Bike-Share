require 'rails_helper'

describe 'user visits visits home page' do
  it 'can navigate to new user page and create an account' do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')

    visit '/'
    click_on 'Login'
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on 'Log In'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.address)
    expect(page).to have_link('Logout')
    expect(page).to_not have_content('Login')
  end

  it 'user can logout and see a login link' do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to_not have_link('Logout')
    expect(page).to have_content('Login')
  end
end
