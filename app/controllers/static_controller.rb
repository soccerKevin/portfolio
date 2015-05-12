class StaticController < ApplicationController

  def index
  	@social_icons = [
				{name: 'linkedin', link: "https://www.linkedin.com/in/townsenddev" },
				{name: 'twitter', link: "https://twitter.com/SoccerKevin11" },
				{name: 'github', link: "https://github.com/soccerKevin" },
				{name: 'blog', link: "/articles" }
			]
  end

  def about_me
  	@page_name = "about_me"
  end
end
