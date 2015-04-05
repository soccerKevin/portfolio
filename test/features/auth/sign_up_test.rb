require "test_helper"

feature("
  As a site visitor, I want to be able to sign up for an account,
  so that I can perform actions that require me to be logged in.") do
  scenario "sign up" do
    # Given a registration form
    visit root_path
    click_on "Sign up"

    # When I register with valid info
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    # Then I should be signed up
    page.must_have_content "Logged in as"
    page.wont_have_content "There was a problem with your sign up"
  end
end


feature "As a user I want to be able to sign in" do
  scenario "Sign In" do
    login_as
    
    page.text.must_include "Logged in as"
  end

  scenario "Sign Out" do
    login_as

    click_on "Logout"
    page.text.must_include "Sign up"
  end
end
