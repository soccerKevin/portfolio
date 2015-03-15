require "test_helper"

class Auth::SignUpTest < Capybara::Rails::TestCase
  feature "As a site visitor
          I want to be able to create an account
          so that I can access to more parts of the site" do
    scenario "Sign Up" do
      #Given a registration form
      visit root_path
      click_on("Sign Up")

      #When I register with valid credentials
      fill_in "Email", with: "testUser@test.com"
      fill_in "Password", with: "testPassword"
      fill_in "Password Confirmation", with: "testPassword"
    end
  end
end
