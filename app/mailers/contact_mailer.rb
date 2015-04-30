class ContactMailer < ApplicationMailer
	# default to: "soccerKevint11@gmail.com"

	def contact_email(contact)
		@contact = contact
	  data = {
		  from: "#{@contact.name} <soccerkevint11@gmail.com>",
		  to: "<soccerKevint11@gmail.com>",
		  subject: "Portfolio",
		  html: template
		}
	  RestClient.post "https://api:key-f5a5fc3d68380a56a48edd78f83cabe5"\
  	"@api.mailgun.net/v3/townsendwebdd.com/messages", data

		true
	end

	def template
		body = File.open('app/views/contact_mailer/contact_email.html').read
		template = ERB.new(body)
		template.result(binding)
	end
end
