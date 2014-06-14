class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
	  #The value of the vote
	  t.integer :value
	  #The frosh that this vote is for
	  #t.belongs_to :frosh
	  t.references :frosh

      t.timestamps
    end
  end
end
