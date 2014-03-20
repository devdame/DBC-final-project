class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :topic
      t.belongs_to :school
      t.integer :positive_post_count, :default => 0
      t.integer :negative_post_count, :default => 0
      t.integer :neutral_post_count, :default => 0
      t.integer :mixed_post_count, :default => 0

      t.timestamps
    end
  end
end
