require 'rails_helper'

describe 'visit user edit page' do
  it 'can edit user with all fields present' do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_user_path(user)
    # save_and_open_page
    # binding.pry
    new_name = 'blob'
    new_email = 'blob@blob.blob'
    new_password = '12345'
    new_address = '321 Maple St'
    fill_in 'user[name]', with: new_name
    fill_in 'user[email]', with: new_email
    fill_in 'user[password]', with: new_password
    fill_in 'user[address]', with: new_address
    click_on 'Update'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content(new_name)
    expect(page).to have_content(new_email)
    expect(page).to have_content(new_address)
  end

  it 'fails with blank fields' do

  end

  # it 'does not allow users to access other users' do
  #   user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')
  #
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #   visit edit_user_path
  #
  #
  # end
end
