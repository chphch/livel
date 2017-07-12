class Feed < ApplicationRecord
  belongs_to :user
  has_many :feed_comments
  has_many :feed_artists
  has_many :feed_likes
  has_many :connect_urls
end
