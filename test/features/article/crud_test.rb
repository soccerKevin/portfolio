require 'test_helper.rb'


feature "As a developer I want all parts of crud to work on my blog" do 
  scenario "As a blog owner, I want to index all blog entries" do
    #given I visit the articles page
    visit articles_path

    #then I should see some articles
    page.text.must_include "Listing Articles"
  end

  scenario "As a blog owner, I want to show all blog entries" do
    #given I visit the articles page
    visit article_path articles(:first)

    #then I should see some articles
    page.text.must_include "A Title"
  end

  scenario "As a blog owner, I want to create a new article" do
    login
    #when I fill out a new article form
    visit new_article_path
    fill_in "Title", with: "A Title"
    fill_in "Body", with: "Some content here"

    #when I submit article 
    click_on "Create Article"

    #then I should have a new article
    page.text.must_include "Article was successfully created"
  end

  scenario "As a blog owner, I want to edit an existing article" do
    login
    #given I have an existing article
    visit edit_article_path articles(:first)
    fill_in "Title", with: "A Different Title"

    #when I edit the article
    click_on "Update Article"

    #then the article should be updated
    page.text.must_include "Article was successfully updated"
  end

  scenario "As a blog owner, I want to delete existing article" do
    login
    #given that I have an existing article
    visit articles_path
    first(:link, "Destroy").click

    page.text.must_include "Article was successfully destroyed"
  end
end
