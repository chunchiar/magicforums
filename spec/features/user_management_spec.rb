require "rails_helper"

RSpec.feature "User Management", type: :feature , js:true do

  scenario "User registers" do

    visit new_user_path
    fill_in 'username_field', with: 'ironman'
    fill_in 'email_field', with: 'ironman@email.com'
    fill_in 'password_digest_field', with: 'password'
    fill_in 'password_digest_field_1', with: 'password'

    click_button('Create Account')

    user = User.find_by(email: "ironman@email.com")

    expect(user).to be_present
    expect(user.email).to eql("ironman@email.com")
    expect(user.username).to eql("ironman")
    expect(find('.flash-messages .message').text).to eql("You've created a new user.")
    expect(page).to have_current_path(root_path)
  end

  scenario "User update" do

    visit root_path
    visit new_session_path

    fill_in 'email_field', with: "ironman@email.com"
    fill_in 'password_digest_field', with: "password"

    click_button("Log In")

    click_button("close-flash")

    click_link("ironman")

    fill_in 'username_field', with: 'newironman'
    fill_in 'email_title_field', with: 'newironman@email.com'

    click_button('Update Account')

    user = User.find_by(username: "newironman")

    expect(user.username).to eql("newironman")
    expect(find('.flash-messages .message').text).to eql("You've updated the user.")
  end
end
