class AnalyzedPost < ActiveRecord::Base
  belongs_to :school
  has_many :keywords
end
