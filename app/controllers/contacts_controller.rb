class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)

		if @contact
			@status = "Thank you for your email, I will respond shortly"
			return render :new, status: :ok
		else
			@status = "There was a problem sending your message, please try again"
			return render :new, status: 422
		end
	end

private
	def contact_params
		params.require(:contact).permit(:name, :from_email, :body)
	end
end
