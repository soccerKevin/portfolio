require "test_helper"

feature "As an editor, I want access to all articles" do
  scenario "As an editor, I want to see all articles" do
    login(:editor)

    page.text.must_include users(:editor).email
    page.text.must_include users(:author2).email
    page.text.must_include "Published"
  end

  scenario "As an editor, I want to edit all unpublished articles" do
    #given that I've logged in
    login(:editor)

    visit articles_path
    #when I click edit on an article
    find("table").first(:link, "Edit").click

    #then It should not be published
    page.text.wont_include "Published"
  end

  scenario "As an editor, I want to create new articles" do
    #given that I've logged in
    login(:editor)

    #when I click new article
    create_article

    #then I will see it, it will be mine
    page.text.must_include "New Body"
    page.text.must_include users(:editor).email
  end

  scenario "As an editor, I want to delete all articles" do
    #given that I've logged in
    login(:editor)

    visit articles_path
    page.text.must_include "Published"

    #when I click edit on an article
    find("table").first(:link, "Destroy").click

    #I should see the deleted screen
    page.text.must_include "Article was successfully destroyed."
  end

  scenario "As an editor I want to publish articles so that I can make articles live on the site" do
    #given that I've logged in
    login(:editor)

    visit articles_path

    page.must_have_field 'published'

    # TODO probably something about saving it here
  end
end
