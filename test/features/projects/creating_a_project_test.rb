
require 'test_helper.rb'

feature "As the site owner, I want to add a portfolio item so that I can show off my work" do
  scenario "adding a new project" do
    visit projects_path
    click_on "New Project"
    fill_in "Name", with: "Code Fellows Portfolio"
    fill_in "Technologies used", with: "Rails, Ruby, Bootstrap, HTML5, CSS3"
    click_on "Create Project"
    page.text.must_include "Project has been created"
    assert page.has_css?("#notice"), "Expected a flash notice on this page, none found."
    page.status_code.must_equal 200
  end
end
    

feature "As a developer I want all parts of crud to work for my projects" do 
  scenario "As a freelancer, I want to display all my projects" do
    #given I visit the articles page
    visit projects_path

    #then I should see some articles
    page.text.must_include "Listing Articles"
  end

  scenario "As a freelancer, I want to show 1 project" do
    #given I visit the articles page
    visit projects_path articles(:first)

    #then I should see some articles
    page.text.must_include "A Title"
  end

  scenario "As a freelancer, I want to create new projects" do
    #when I fill out a new article form
    visit new_projects_path
    fill_in "Title", with: "A Title"
    fill_in "Body", with: "Some content here"

    #when I submit article 
    click_on "Create Article"

    #then I should have a new article
    page.text.must_include "Article was successfully created"
  end

  scenario "As a freelancer, I want to edit existing projects" do
    #given I have an existing article
    visit edit_projects_path articles(:first)
    fill_in "Title", with: "A Different Title"

    #when I edit the article
    click_on "Update Article"

    #then the article should be updated
    page.text.must_include "Article was successfully updated"
  end

  scenario "As a freelancer, I want to delete existing projects" do
    #given that I have an existing article
    visit projects_path
    click_on "Destroy"

    page.text.must_include "Article was successfully destroyed"
  end
end
