class ReferenceWord < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :name, presence: true

  belongs_to :topic
end
