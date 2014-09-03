class CreateFroshes < ActiveRecord::Migration
  def change
    create_table :froshes do |t|
	  t.string :name
      t.string :last_name

	  t.integer :dinner
	  t.integer :dessert

      t.string :image_url
      t.string :comments
      t.string :anagram
      t.string :interest_url

      t.string :prelim_rank
	  t.integer :list

      t.timestamps
    end
  end
end
