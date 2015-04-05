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

  scenario "As a blog owner, I want to edit an existing article" do
    login_as
    #given I have an existing article
    visit edit_article_path articles(:first)
    fill_in "Title", with: "A Different Title"

    #when I edit the article
    click_on "Update Article"

    #then the article should be updated
    page.text.must_include "Article was successfully updated"
  end

end
