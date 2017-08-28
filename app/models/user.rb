class User < ApplicationRecord
  searchkick callbacks: :async
  has_many :curation_likes
  has_many :feeds
  has_many :feed_likes
  has_many :feed_comments
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :connect_urls
  has_many :recent_keywords
  mount_uploader :profile_img, S3Uploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]
  validates :email, presence: true, confirmation: true, uniqueness: true
  validates :nickname, presence: true, confirmation: true, length: {maximum: 20}, uniqueness: true
  validates :password, presence: true, confirmation: true, length: {in: 8..20}
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: password_length, allow_blank: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.name  # assuming the user model has a name
      user.remote_profile_img_url = auth.info.image.gsub('http://','https://') +
            '?type=large' # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # whether or not the page changes
  def remote

  end

  def isFacebook?
    self.provider == "facebook";
  end
end