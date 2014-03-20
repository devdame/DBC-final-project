class CreateReferenceWords < ActiveRecord::Migration
  def change
    create_table :reference_words do |t|
      t.string :name
      t.belongs_to :topic

      t.timestamps
    end
  end
end
