class CreateAnalyzedPosts < ActiveRecord::Migration
  def change
    create_table :analyzed_posts do |t|
      t.belongs_to :school
      t.string :overall_sentiment
      t.string :original_publish_time

      t.timestamps
    end
  end
end
