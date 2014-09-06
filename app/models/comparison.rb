class Comparison < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :winner, class_name: :Frosh
  belongs_to :loser, class_name: :Frosh
end
