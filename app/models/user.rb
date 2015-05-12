class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :articles, foreign_key: "author_id"
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    auth_search = {
      email: auth.info.email
    }

    # auth.slice(email: auth.info.email, provider: auth.provider, uid: auth.uid)
    where(auth_search.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid =  auth.uid
      user.username = auth.info.nickname
      user.email = auth.uid
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    false
    # super && provider.blank? #&& !self.require_email
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def editor?
    role == "editor"
  end

  def author?
    role == "author"
  end
end
