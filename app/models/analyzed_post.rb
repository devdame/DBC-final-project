class AnalyzedPost < ActiveRecord::Base
  validates :school_id, presence: true
  validates :overall_sentiment, presence: true
  validates :original_publish_time, presence: true

  belongs_to :school
  has_many :keywords
end
