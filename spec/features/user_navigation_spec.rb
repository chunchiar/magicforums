require "rails_helper"

RSpec.feature "User Navigation", type: :feature , js: true do
  before(:all) do
    @user = create(:user)
  end

  scenario "User visits home page" do

    visit root_path

    expect(page).to have_current_path(root_path)
  end

  scenario "User clicks on about page" do

    visit about_path

    expect(page).to have_current_path(about_path)
  end

  scenario "User clicks on register" do

    visit new_user_path

    expect(page).to have_current_path(new_user_path)
  end

  scenario "User clicks on login" do

    visit root_path
    click_link("Login")
    visit new_session_path

    expect(page).to have_current_path(new_session_path)

  end

  scenario "User clicks on topics" do

    visit root_path
    click_link("Login")
    visit new_session_path

    fill_in 'email_field', with: @user.email
    fill_in 'password_digest_field', with: @user.password

    click_button("Log In")
    click_button("close-flash")
    click_link("Topics")

    expect(page).to have_current_path(topics_path)
  end


end
