class School < ActiveRecord::Base
  validates :name, presence: true
  validates :student_body_count, presence: true
  validates :first_post_time, presence: true
  validates :most_recent_post_time, presence: true
  validates :geofeedia_id, presence: true

  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts

end
