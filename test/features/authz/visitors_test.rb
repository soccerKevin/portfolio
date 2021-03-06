require "test_helper"

feature "As a visitor, I want to see all published articles" do
  scenario "As a visitor, I want to see published articles" do
    visit articles_path

    page.text.must_include "Published"
    page.text.wont_include "Unpublished"
  end

  scenario "As a visitor, I dont want to edit articles" do
    visit articles_path
    page.text.wont_include "Edit"

    visit new_article_path
    page.text.wont_include "Create Article"
  end

  scenario "As a visitor, I dont want to create new articles" do
    #shouldn't see new artile link on articles.index
    visit articles_path
    page.text.wont_include "New Article"
  end

  scenario "As a visitor, I dont want to delete any articles" do
    visit articles_path
    page.text.wont_include "Destroy"
  end
end
