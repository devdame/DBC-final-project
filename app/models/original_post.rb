class OriginalPost < ActiveRecord::Base
  validates :school_id, presence: true
  validates :text, presence: true
  validates :geofeedia_school_id, presence: true
  validates :original_publish_time, presence: true

  belongs_to :school
end
