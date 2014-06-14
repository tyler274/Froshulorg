class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
	  t.integer :winner
	  t.integer :loser
      t.timestamps
    end
  end
end
