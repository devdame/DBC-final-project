class School < ActiveRecord::Base
  validates :name, presence: true
  validates :most_recent_post_time, presence: true

  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts

end
