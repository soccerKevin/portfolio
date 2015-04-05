require "test_helper"

feature "As an editor, I want access to all articles" do
  
  scenario "As an editor, I want to see all articles" do
    login_as(:editor)

    visit articles_path
    page.text.must_include users(:editor).email
    page.text.must_include users(:author1).email

  end

  scenario "As an editor, I want to edit all articles" do
    #given that I've logged in
    login_as(:editor)

    visit articles_path
    #when I click edit on an article
    find("table").first(:link, "Destroy").click
  end

  scenario "As an editor, I want to create new articles" do
    #given that I've logged in
    login_as(:editor)

    #when I click new article
    create_article

    #then I will see it, it will be mine
    page.text.must_include "New Body"
    page.text.must_include users(:editor).email
  end

  scenario "As an editor, I want to delete everyone's articles" do
    #given that I've logged in
    login_as(:editor)

    visit articles_path

    #when I click edit on an article
    find("table").first(:link, 'Destroy').click

    #I should see the deleted screen
    #page.text.must_include "Article was successfully destroyed."
  end

  scenario "As an editor I want to publish articles so that I can make articles live on the site" do
    #given that I've logged in
    login_as(:editor)

    visit articles_path

    find("table tr:nth-child(2)").first(:link, "Edit").click
    page.must_have_field 'Published'

    # TODO probably something about saving it here
  end

  scenario "As an editor I should be able to create new published articles?????" do
    login_as(:editor)

    visit new_article_path

    fill_in "Title", with: articles(:first).title
    fill_in "Body", with: articles(:first).body
    check "Published"
    click_on "Create Article"

    page.text.must_include "Status: Published"

  end
end
