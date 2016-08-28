require "rails_helper"

RSpec.feature "User Session", type: :feature, js: true do
  before(:all) do
    @user = create(:user)
  end

  scenario "User visit log in page" do
    visit new_session_path

    expect(page).to have_current_path(new_session_path)
    expect(find_button('Log In')).to be_present
  end

  scenario "User attempt to log in" do
    visit new_session_path

    fill_in 'email_field', with: @user.email
    fill_in 'password_digest_field', with: @user.password

    click_button("Log In")

    user = User.find_by(email: "user@gmail.com")

    expect(page).to have_current_path(topics_path)
    # expect(current_path).to eq(topics_path)
    expect(find('.flash-messages .message').text).to eql("Welcome back #{@user.username}")
  end

  scenario "User attempt to log out" do

    visit new_session_path

    fill_in 'email_field', with: @user.email
    fill_in 'password_digest_field', with: @user.password

    click_button("Log In")

    visit root_path
    click_on("Logout")

    expect(page).to have_current_path(root_path)
    expect(find('.flash-messages .message').text).to eql("You've been logged out")
    expect(find_link('Register')).to be_present
    expect(find_link('Login')).to be_present
  end

end
