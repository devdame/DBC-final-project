class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :student_body_count
      t.string :first_post_time
      t.string :most_recent_post_time
      t.string :geofeedia_id
      t.integer :post_count, default: 0
      t.integer :positive_post_count, default: 0
      t.integer :negative_post_count, default: 0
      t.integer :neutral_post_count, default: 0
      t.integer :mixed_post_count, default: 0

      t.timestamps
    end
  end
end
