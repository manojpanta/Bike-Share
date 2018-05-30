require 'rails_helper'

describe 'admin can login' do
  it 'sees admin dashboard' do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    visit '/'

    click_on 'Login'
    fill_in :email, with: admin.email
    fill_in :password, with: admin.password
    click_on 'Log In'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content("Logged in as Admin User: #{admin.name}")
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')
  end
end
