class OriginalPost < ActiveRecord::Base
  validates :school_id, presence: true
  validates :text, presence: true

  belongs_to :school
end
