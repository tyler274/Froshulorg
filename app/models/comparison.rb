class Comparison < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :winner, class_name: :frosh
  belongs_to :loser, class_name: :frosh
end
