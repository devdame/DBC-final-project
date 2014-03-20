class Rating < ActiveRecord::Base
  belongs_to :topic
  belongs_to :school
end
