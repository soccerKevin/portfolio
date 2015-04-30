class Contact < ActiveRecord::Base
	validates_presence_of :name
	validates :from_email, presence: true, uniqueness: true, email: true
	validates_presence_of :body
end 
