class School < ActiveRecord::Base
  validates :name, presence: true
  validates :student_body_count, presence: true
  validates :geofeedia_id, presence: true

  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts

  def self.create_ratings
    self.all.each do |school|
      Topic.all.each do |topic|
        new_rating = Rating.create(topic_id: topic.id, school_id: school.id)
        new_rating.save
      end
    end
  end

end
