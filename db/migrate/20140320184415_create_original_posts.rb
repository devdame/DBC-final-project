class CreateOriginalPosts < ActiveRecord::Migration
  def change
    create_table :original_posts do |t|
      t.text :text
      t.belongs_to :school

      t.timestamps
    end
  end
end
