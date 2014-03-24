class CreateOriginalPosts < ActiveRecord::Migration
  def change
    create_table :original_posts do |t|
      t.text :text
      t.belongs_to :school
      t.string :geofeedia_school_id
      t.string :original_publish_time
      t.string :external_id

      t.timestamps
    end
  end
end
