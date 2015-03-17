require 'test_helper'

feature "As a user I want my articles connected to my account so that I can be attributed as author" do
  scenario "As a signed in user, I can edit articles" do
    #given I'm signed in
    visit user_session_path

  end
end
