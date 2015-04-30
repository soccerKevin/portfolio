class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		@status = "Thank you for your message"
		render :new, status: :ok
	end

private
	def contact_params
		params.require(:contact).permit(:name, :email, :body)
	end
end
