class ReferenceWord < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :name, presence: true, uniqueness: true

  belongs_to :topic
  has_many :school_word_counts

end
