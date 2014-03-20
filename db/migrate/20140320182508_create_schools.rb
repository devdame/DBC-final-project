class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :post_count
      t.integer :positive_post_count
      t.integer :negative_post_count
      t.integer :neutral_post_count
      t.integer :mixed_post_count

      t.timestamps
    end
  end
end
