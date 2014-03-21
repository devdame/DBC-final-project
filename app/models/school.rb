class School < ActiveRecord::Base
  validates :name, presence: true
  validates :student_body_count, presence: true

  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts

end
