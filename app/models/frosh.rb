class Frosh < ActiveRecord::Base
  resort!
  # attr_accessible :title, :body
  has_many :votes

  def prelim_score
    @prelim_score ||= votes.map(&:value).inject{ |sum, x| sum + x } || 0
  end
end
