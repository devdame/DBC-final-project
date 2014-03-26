class AddTopicIdToSchoolWordCounts < ActiveRecord::Migration
  def change
    add_column :school_word_counts, :topic_id, :integer
    SchoolWordCount.all.each do |schoolwordcount|
      schoolwordcount.update_attributes!(:topic_id => nil)
    end
  end
end
