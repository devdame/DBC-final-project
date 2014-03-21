class CreateSchoolWordCounts < ActiveRecord::Migration
  def change
    create_table :school_word_counts do |t|
      t.belongs_to :school
      t.belongs_to :reference_word
      t.integer :word_count, default: 0
      t.integer :positive_word_count, default: 0
      t.integer :negative_word_count, default: 0
      t.integer :neutral_word_count, default: 0
      t.integer :mixed_word_count, default: 0

      t.timestamps
    end
  end
end
