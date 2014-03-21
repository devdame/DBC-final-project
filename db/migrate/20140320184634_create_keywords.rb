class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.belongs_to :analyzed_post
      t.string :text
      t.string :sentiment
      t.float :confidence

      t.timestamps
    end
  end
end
