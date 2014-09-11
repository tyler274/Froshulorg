class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :value
  belongs_to :frosh
end
