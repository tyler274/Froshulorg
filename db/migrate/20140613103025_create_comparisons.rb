class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
#	  t.integer :winner
#	  t.integer :loser
      t.belongs_to :winner
      t.belongs_to :loser
      t.timestamps
    end
  end
end
