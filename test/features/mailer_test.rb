require "test_helper"

feature "As a developer I want people to be able to email me" do
	scenario "It should eliver a signup email" do
		UserMailer.should_receive(:deliver_signup).with("email@example.com", "Yahootie")
		post :signup, "Email" => "email@example.com", "Name" => "Yahootie"
	end
end

feature "Signup Email" do
	include EmailSpec::Helpers
	include EmailSpec::Matchers
	include Rails.application.routes.url_helpers

	before(:all) do
		@email = UserMailer.create_signup("jojo@yahoo.com", "Jojo Binks")
	end

	scenario "should email the user a message upon signup" do
		@email.should deliver_to("jojo@yahoo.com")
		@email.should have_body_text(/Jojo Binks/)
		@email.should have_body_text(/#{confirm_account_url}/)
		@email.should have_subject(/Account confirmation/)
	end
end
