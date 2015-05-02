class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
	before_action :body_class

private
 	def body_class
 		set_tab action_name.to_sym
 	end

end
