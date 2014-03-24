class School < ActiveRecord::Base
  validates :name, presence: true
  validates :student_body_count, presence: true
  validates :geofeedia_id, presence: true
  after_save :create_ratings

  has_many :ratings
  has_many :original_posts
  has_many :analyzed_posts
  has_many :school_word_counts


  def create_ratings
    Topic.all.each do |topic|
      new_rating = Rating.create(topic_id: topic.id, school_id: self.id)
      new_rating.save
    end
  end

  def social_media_activity
    post_count/student_body_count.to_f
  end

  def positive_vibe_ratio
    positive_post_count/post_count.to_f
  end

  def negative_vibe_ratio
    negative_post_count/post_count.to_f
  end

  def neutral_vibe_ratio
    neutral_post_count/post_count.to_f
  end

  def mixed_vibe_ratio
    mixed_post_count/post_count.to_f
  end

end
