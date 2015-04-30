class ContactMailer < ApplicationMailer
	# default to: "soccerKevint11@gmail.com"

	def contact_email(contact)
		@contact = contact
	  data = {
		  from: "#{@contact.name} <#{ENV['EMAIL']}>",
		  to: "<#{ENV['EMAIL']}>",
		  subject: "Portfolio",
		  html: template
		}
	  RestClient.post "https://api:#{ENV['MAILGUN_KEY']}"\
  	"@#{ENV['MAILGUN_API_SECRET']}", data

		true
	end

	def template
		body = File.open('app/views/contact_mailer/contact_email.html').read
		template = ERB.new(body)
		template.result(binding)
	end
end
