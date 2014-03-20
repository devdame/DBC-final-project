class CreateAnalyzedPosts < ActiveRecord::Migration
  def change
    create_table :analyzed_posts do |t|
      t.belongs_to :school
      t.string :overall_sentiment

      t.timestamps
    end
  end
end
