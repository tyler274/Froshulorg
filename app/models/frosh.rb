class Frosh < ActiveRecord::Base
  resort!
  # attr_accessible :title, :body
  has_many :votes

  has_many :won_compares, class_name: :Comparison, foreign_key: :winner_id, dependent: :destroy
  has_many :lost_compares, class_name: :Comparison, foreign_key: :loser_id, dependent: :destroy

  def prelim_score
    @prelim_score ||= votes.map(&:value).inject{ |sum, x| sum + x } || 0
  end
end
