class StaticController < ApplicationController

  def index
  	@social_icons = [
				{name: 'linkedin', link: "https://www.linkedin.com/in/townsenddev" },
				{name: 'twitter', link: "https://twitter.com/SoccerKevin11" },
				{name: 'github', link: "https://github.com/soccerKevin" },
				{name: 'blog', link: "/articles" }
			]
  end

  def about
  	@page_name = "about_me"
    @skill_set1 = [
      {name: 'HTML5', rank: '95', color: 'red'},
      {name: 'HAML', rank: '85', color: 'red'},
      {name: 'CSS3', rank: '95', color: 'green'},
      {name: 'BOOTSTRAP', rank: '85', color: 'blue'},
      {name: 'Git', rank: '85', color: 'gray'}
    ]
    @skill_set2 = [
      {name: 'JavaScript', rank: '90', color: 'blue'},
      {name: 'AngularJS', rank: '85', color: 'green'},
      {name: 'Coffee Script', rank: '85', color: 'brown'},
      {name: 'Ruby/Rails', rank: '80', color: 'red'},
      {name: 'BDD', rank: '80', color: 'green'}
    ]
  end
end
