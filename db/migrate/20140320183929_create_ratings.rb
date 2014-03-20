class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :topic
      t.belongs_to :school
      t.integer :positive_post_count
      t.integer :negative_post_count
      t.integer :neutral_post_count
      t.integer :mixed_post_count

      t.timestamps
    end
  end
end
