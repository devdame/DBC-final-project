class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      belongs_to :topic
      belongs_to :school
      t.integer :positive_post_count
      t.integer :negative_post_count
      t.integer :neutral_post_count
      t.integer :mixed_post_count

      t.timestamps
    end
  end
end
