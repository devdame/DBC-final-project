class Topic < ActiveRecord::Base
  validates :name, presence: true

  has_many :reference_words
  has_many :ratings
end
