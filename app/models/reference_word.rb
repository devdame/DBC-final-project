class ReferenceWord < ActiveRecord::Base
  before_save :remove_spaces
  validates :topic_id, presence: true
  validates :name, presence: true
  validates :canonical_name, uniqueness: true

  belongs_to :topic
  has_many :school_word_counts

  def remove_spaces
    self.canonical_name = self.name.downcase.split(' ').join.gsub("#", "")
  end

end
