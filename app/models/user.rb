class User < ApplicationRecord
  has_many :curation_likes
  has_many :feeds
  has_many :feed_likes
  has_many :feed_comments
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :connect_urls
  has_many :recent_keywords

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.name   # assuming the user model has a name
      user.profile_img = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
