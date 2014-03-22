class School < ActiveRecord::Base
  validates :name, presence: true
  validates :student_body_count, presence: true
  validates :geofeedia_id, presence: true

  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts

  def social_media_activity
    post_count/student_body_count.to_f
  end

  def positive_vibe_ratio
    positive_post_count/post_count.to_f
  end

  def negative_vibe_ratio
    negative_post_count/post_count.to_f
  end

end
