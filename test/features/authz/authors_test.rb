require "test_helper"

feature "As an author, I want access to my unpublished articles" do
  scenario "As an author, I want to see all my articles" do
    login(:author)
    page.text.must_include users(:author1).email
    page.text.wont_include users(:author2).email
  end

  scenario "As an author, I want to edit my unpublished articles" do
    #given that I've logged in
    login(:author)
    visit articles_path
    #when I click edit on an article
    find("table").first(:link, "Edit").click

    #then It should not be published
    page.text.wont_include "Published"
  end

  scenario "As an author, I want to create new articles" do
    #given that I've logged in
    login(:author)
    #when I click new article
    create_article

    #then I will see it
    page.text.must_include "New Body"

  end

  scenario "As an author, I want to delete my unpublished articles" do
    #given that I've logged in
    login(:author)
    visit articles_path
    #when I click edit on an article
    find("table").first(:link, "Destroy").click

    #I should see the deleted screen
    page.text.must_include "Article was successfully destroyed."
  end
end



