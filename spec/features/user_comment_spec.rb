require "rails_helper"

RSpec.feature "User Comment", type: :feature , js: true do
  before(:all) do
    @user = create(:user)
    @topic = create(:topic)
    @post = create(:post, topic_id: @topic.id, user_id: @user.id)
    @comment = create(:comment, post_id: @post.id, user_id: @user.id)
  end

  scenario "User visit comments index page, add and delete comment" do

    visit("http://localhost:3000")
    click_link("Login")
    visit new_session_path

    fill_in 'email_field', with: "user0@gmail.com"
    fill_in 'password_digest_field', with: "user0"

    click_button("Log In")
    click_button("close-flash")
    click_link("Topics")
    click_link("Topic 1")
    click_link("Post 1")

    fill_in 'comment_body_field', with: 'This is a new comment'

    click_button("Create Comment")

    expect(find('.flash-messages .message').text).to eql("You've created a new comment.")
    expect(page).to have_content('This is a new comment')
    click_button("close-flash")

    find('.fa-thumbs-o-up').click
    expect(find(".voting-score")).to have_content("1")
    click_button("close-flash")

    find('.fa-thumbs-o-down').click
    expect(find(".voting-score")).to have_content("-1")

    find('.fa-trash').click

    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content('This is a new comment')
  end

end
