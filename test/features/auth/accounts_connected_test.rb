require 'test_helper'

feature "As a user I want my articles connected to my account so that I can be attributed as author" do
  scenario "As a signed in user, I can see articles and that articles have authors" do
    login_as

    visit articles_path

    #authors do have articles should this succeed
    page.text.must_include users(:author1).email
    page.text.wont_include users(:author2).email
  end

  scenario "As a signed in user, I can edit articles" do
    login_as

    visit articles_path
    find("table").first(:link, "Edit").click

    fill_in "Title", with: "something"
    fill_in "Body", with: "Something2"
    click_on "Update Article"

    page.text.must_include "Article was successfully updated."

  end

end


