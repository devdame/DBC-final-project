class Keyword < ActiveRecord::Base
  validates :analyzed_post_id, presence: true
  validates :text, presence: true, uniqueness: true
  validates :sentiment, presence: true
  validates :confidence, presence: true

  belongs_to :analyzed_post
end
