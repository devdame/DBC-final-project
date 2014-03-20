class Rating < ActiveRecord::Base
  validates :school_id, presence: true
  validates :topic_id, presence: true

  belongs_to :topic
  belongs_to :school
end
