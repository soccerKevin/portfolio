class StaticController < ApplicationController
	before_action :body_class

  def index
  end

  def about_me
  	@page_name = "about_me"
  end

 private
 	def body_class
 		set_tab action_name.to_sym
 	end
end
