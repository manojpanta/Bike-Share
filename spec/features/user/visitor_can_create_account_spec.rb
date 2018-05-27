require 'rails_helper'

describe 'user visits visits home page' do
  it 'can navigate to new user page and create an account' do
    visit '/'

    click_on 'Login'

    expect(current_path).to eq('/login')

    click_on 'Create Accout'

    name = 'bob'
    email = 'bob@bob.bob'
    password = '1234'
    address = '123 Elm St'
    fill_in 'user[name]', with: name
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[address]', with: address
    click_button 'Create Account'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as #{name}")
    expect(page).to have_content(email)
    expect(page).to have_content(address)
    expect(page).to have_link('Logout')
    expect(page).to_not have_content('Login')
  end
end
