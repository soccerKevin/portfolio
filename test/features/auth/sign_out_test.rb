require 'test_helper'

feature "As a user I want to sign out so other users can't use my account" do
  scenario "As a user I want to sign out" do
    #given that I can sign in
    visit root_path
    #click_on "Sign In"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Log in"
    
    page.text.must_include "logged in as"
    #then I should be able to sign out
    click_on "Logout"
    page.text.must_include "Sign up"
  end
end
