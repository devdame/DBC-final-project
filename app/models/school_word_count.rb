class SchoolWordCount < ActiveRecord::Base
  validates :school_id, presence: true
  validates :reference_word_id, presence: true
  validates :topic_id, presence: true

  belongs_to :school
  belongs_to :reference_word
  belongs_to :topic


  def reference_word_activity_ratio
    rating = Rating.where(topic_id: self.reference_word.topic.id, school_id: self.school.id)[0]
    word_count/rating.total_post_count.to_f
  end

  def word_positivity_ratio
    positive_word_count/word_count.to_f
  end

  def word_negativity_ratio
    negative_word_count/word_count.to_f
  end

  def word_neutral_ratio
    neutral_word_count/word_count.to_f
  end

  def word_mixed_ratio
    mixed_word_count/word_count.to_f
  end

end
