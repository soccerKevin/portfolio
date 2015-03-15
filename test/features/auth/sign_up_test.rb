require "test_helper"

feature "As a visitor, I want to sign up, so that I can use my account" do
  scenario "" do
    #when I click on Sign Up, I should get a registration form
    visit root_path
    click_on "Sign Up"

    #then I register with valid info
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create Authenticate"

    #then I should have an account
    page.must_have_content "welcome! You have signed up successfully"
    page.wont_have_content "There was a probem with your sign up"
  end
end
