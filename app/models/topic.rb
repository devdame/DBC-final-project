class Topic < ActiveRecord::Base
  has_many :reference_words
  has_many :ratings
end
