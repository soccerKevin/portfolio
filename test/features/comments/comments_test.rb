require "test_helper"

feature "As a visitor I want to be to able to comment on articles so that I can support articles I like" do

  scenario "As a visitor, I want to comment on articles" do
    login_as
    #given that I see the articles
    visit articles_path

    #when I want to comment on one
    within "tr:nth-child(2)" do
      click_on "Show" 
    end

    #then I can fill out the comment form and create a comment
    fill_in "Commenter name", with: "Troller"
    fill_in "Content", with: "Get a JOB!!!!"

    click_on "Create Comment"

    page.text.must_include "Get a JOB!!!!"
  end

  scenario "As a visitor, I want to be able view comments for an article" do
    #given that I see the articles
    visit articles_path

    #when I view an article
    first(:link, "Show").click

    #I should see the comments for the article
    page.text.must_include "Get a JOB!!!"
    page.text.must_include "Stop Trolling"
  end

  scenario "As an editor, I want to be able to publish comments" do
    #given that I see the article has comments
    visit articles_path

    #when I view an article
    first(:link, "Show").click

    #should see comments and therefore be able to publish them
    #assert publish for a comment here

  end

  scenario "As an editor, I want to be able to delete comments" do
    #given that I see the article has comments
    visit articles_path

    #when I view an article
    first(:link, "Show").click

    #then I can delete an article
    #click on delete btn here
  end
end
