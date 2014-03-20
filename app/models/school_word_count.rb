class SchoolWordCount < ActiveRecord::Base
  validates :school_id, presence: true
  validates :reference_word_id, presence: true

  belongs_to :school
  belongs_to :reference_word

end
