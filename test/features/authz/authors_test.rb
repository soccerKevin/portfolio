require "test_helper"

feature "As an author, I want access to my unpublished articles" do
  scenario "As an author, I want to see all my articles" do
    login(:author1)
    page.text.must_include users(:author1).email
    page.text.wont_include users(:author2).email
  end

  scenario "As an author, I want to edit my unpublished articles" do
    #given that I've logged in
    login(:author1)
    visit articles_path
    #when I click edit on an article
    find("table").first(:link, "Edit").click

    #then It should not be published
    page.text.wont_include "Published"
  end

  scenario "As an author, I should not be able to create new published articles" do
    login(:author1)
    visit new_article_path
    page.wont_have_field('published')
  end

  scenario "As an author, I want to create new articles" do
    #given that I've logged in
    login(:author1)
    #when I click new article
    create_article

    #then I will see it
    page.text.must_include "New Body"

  end

  scenario "As an author, I want to delete my unpublished articles" do
    #given that I've logged in
    login(:author1)
    visit articles_path
    #when I click edit on an article
    find("table").first(:link, "Destroy").click

    #I should see the deleted screen
    page.text.must_include "Article was successfully destroyed."
  end
end



