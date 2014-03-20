class School < ActiveRecord::Base
  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts

end
