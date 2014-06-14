class CreateFroshes < ActiveRecord::Migration
  def change
    create_table :froshes do |t|
	  t.string :name
	  t.integer :dinner
	  t.integer :dessert
	  
	  #t.references :vote
	  #t.integer :vote_id
      t.timestamps
    end
  end
end
