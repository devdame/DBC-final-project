class Rating < ActiveRecord::Base
  validates :school_id, presence: true
  validates :topic_id, presence: true

  belongs_to :topic
  belongs_to :school

  def topic_activity_ratio
    total_post_count/self.school.post_count.to_f
  end

  def topic_positivity_ratio
    positive_post_count/total_post_count.to_f
  end

  def topic_negativity_ratio
    negative_post_count/total_post_count.to_f
  end
end
