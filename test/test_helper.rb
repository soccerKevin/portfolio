ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"
require "minitest/reporters"
require "minitest-matchers"
require "email_spec"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# RSpec.configure do |config|
#   config.include(EmailSpec::Helpers)
#   config.include(EmailSpec::Matchers)
# end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def login_as(role = :author1)
    visit user_session_path

    fill_in "Email", with: users(role).email
    fill_in "Password", with: "password"
    
    click_on "Log in"
  end

  #assuming you are logged in
  def create_article
    visit new_article_path

    fill_in "Title", with: "New Title"
    fill_in "Body", with: "New Body"

    click_on "Create Article"
  end

end
