require 'rails_helper'

describe 'user authorization' do
  it 'cannot show another user info or admin screens' do
    user1 = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')
    user2 = User.create(name: 'blob', email: 'blob@blob.blob', password: '1234', address: '321 Elm St')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/dashboard'

    expect(page).to have_content(user1.name)
    expect(page).to_not have_content(user2.name)
    expect(page).to_not have_content(user2.email)
    expect(page).to_not have_content(user2.address)

    visit '/admin/accessories/new'

    expect(page).to have_content("404: These are not the droids you're looking for")
  end
end
