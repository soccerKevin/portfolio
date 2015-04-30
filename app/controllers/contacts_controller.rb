class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)

		return render :new, status: 422 unless @contact.valid?

		ContactMailer.contact_email(@contact).deliver_now
		@status = "Thank you for your email, I will respond shortly"
		render :new, status: :ok
	end

private
	def contact_params
		params.require(:contact).permit(:name, :from_email, :body)
	end

end
